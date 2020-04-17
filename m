Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0721AD8D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 10:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgDQImQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 04:42:16 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:17996 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbgDQImP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587112935; x=1618648935;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=48hqmZ93MhrQIYizJCeQZA7RBwRvy3EiKXl76vh9Vks=;
  b=FusMHqAbRi7+e/d61NM04c65Lq7qKLlSkIJJAQi3K9WFwuSDZWm6Kbvc
   6Y3kAzqic+RTECrqnkVeGChWyOzjlQIKLT3i0qlftg37zWBaHw9Rl+2jt
   +PpWD+9HmRhrvSnKJAhmDmJiStfqAUL1wI2Run6AOdPmY45dUg7EIUFUx
   USSirDahFocx05d9gDCqxmHS4NSCu8hqGe9ipeUSSGC1pw+lzQgjrIjbp
   6ViKXPyiKsyfHeSoDj7U9SL3n3qJq1x8Vpzku4UwHMKEoocaWmpiaGtCB
   N51fDhxGc/K7H9COzvVHWCmaxlGrsCGvPZ4BbtPxvb2g+y+uE6ZgBHCy2
   A==;
IronPort-SDR: 4xPJoTvQmyJaYBxZBI9JdpTrmXoIyNohbAStsKXTdQjt9pcq1pVMTrJvmq1I13+B1NrruGGUFV
 Bb+FmoMhAJqLQN8djP5zL+LO64F5aosiKlnQwzyJIZE9c/qUDOUl9CDx+KevIaS8l6Ho9fkAPX
 0xBGMewIWXcn47HhCFp18LtTyDENSkjICj/f+G1IJAlT/mUqyXyF7bywcRSv7mQIjMQ6BUt5Xl
 fOeUxqV9sIiu2Ntf5te4I0D4vf/wm5JvSL8ylqdPHLJozvN0DcT/Pds5N8E+Xx7pe0hJZGtcd7
 8nA=
X-IronPort-AV: E=Sophos;i="5.72,394,1580745600"; 
   d="scan'208";a="136980107"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2020 16:42:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMVRj01SmLTQtI3xOt9Kn2TNt6UZ6HzjQK+Xl++JIiIzK1n2GG5w91e7SIpQ+abfAkXlTHL+gIAdQ1sHk/tRpKI8Ml8mQS0KA9OZCWVMFzKV4vCArRhmZgqFDo77hWbto9rVN8MnznGpODqi1Xus2ojBf6crRAAnf7QhCoZ72hHn+KEPbYro6OOQPw8/SG7w89yxMQ0o+t7bx3xPbEfVTH7Gw4F6s5tBXzHElRuDb43VeN2eVngsEOXTrqy+9z3mmioEzNAh8cnHckm0bkxggkQi9GHPgQUVbvsHhbSuZi+WXQPL9Iw/ifdGQOL8M7T28/VuhI2epgXvNL5XRlupjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqRtSq3NSXOQA6WhyJPfROnaJEPqcUnwhDFjxOGENoo=;
 b=Y7m97XbFzCmxdC8SUk+Znd+W58fjFa1hP1WzYjlla2kiBLvV3F/BoDTsbLXEoL7CTanNLI9eAEVMTvHzlep8jzudb/yTa9ZJmGiu3qAFIF7xAgrvWiohG30c1HZzR0AdHVFnvSxle5q9Rl9njCyw3jaUQ+V+Jlyaj/JLV4BBjYQX7Nj/ch/ncIqo1KnpAqlyEPJIop53C2dsmVcESw4rqDC8de+6ZWP0Nj/gu8Jr3+xAt7UYQUV8ahAyc3d6wFb7yCtTXGO+529Cn3nTCkpjbq9/BcRYoRo1REmWcZI08DizY6iIYHFVEeWsRQCZ+xiihf+9NhJ4zTVYyVAfbt2+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqRtSq3NSXOQA6WhyJPfROnaJEPqcUnwhDFjxOGENoo=;
 b=xyp2FynePIjx7TESWq5LeOBZoc2wSKnHQDacMcdJScdExrNkqsEWcrqEjjFl4uGLwZNsZxqUZ2t9IogfANBYnfs27Sj631r8yk67jNZ489NQnH8FwFl6zQrOd6HwYXZmbdLYiuJ5ZGTqyitpmE5fKbJQGrAkxdmVbDdkht+wdus=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3678.namprd04.prod.outlook.com
 (2603:10b6:803:47::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Fri, 17 Apr
 2020 08:42:12 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 08:42:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v6 04/11] block: Introduce REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v6 04/11] block: Introduce REQ_OP_ZONE_APPEND
Thread-Index: AQHWEwUEsEPLapTnp0OqnJ4dRylqQQ==
Date:   Fri, 17 Apr 2020 08:42:12 +0000
Message-ID: <SN4PR0401MB35987433364CCC2F8BEE7E689BD90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
 <20200415090513.5133-5-johannes.thumshirn@wdc.com>
 <20200417074228.jxqk2znfqjfhrwf2@carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 19f08644-fa4c-4ae3-c21e-08d7e2ab391f
x-ms-traffictypediagnostic: SN4PR0401MB3678:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB36780C5DA03F2D0B980569949BD90@SN4PR0401MB3678.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:597;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(66946007)(26005)(8936002)(86362001)(2906002)(478600001)(6916009)(33656002)(71200400001)(66476007)(7696005)(6506007)(52536014)(186003)(4326008)(316002)(66556008)(64756008)(66446008)(5660300002)(76116006)(81156014)(53546011)(91956017)(8676002)(4744005)(9686003)(55016002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yy8BCo/FlZHO535HCcm3TzF62r8G3KlAIvPzB3A3L8EIxrqiyA4hhVHoOQkLdM+LbzHWtG7LTg4yhNRDgATAg+AX7RyMb/aJDTAW3jOy5KqEE9ChQSnBoUn/1C1EudyCznFaAlwBJH7FfFaxskir7I2VTNNhtgbvjsKg+tPTebDPUkc72Veio+ctSfjPSgtJX0DZl9S8uad60Z+tqSi402x5ltr7IghJSdjzgyn10G2qGT+scnb5+ygwGOTpcTiup8l6lDy5db7P6cZIScj0SR/R0MFTQX850A4m5L/TdUFO8deR12q8UgPbud5gC68I/X7qBJrI4jMOrwdQMUpH3NrbVUNC7rabRKCm0aLEmdH7/JR2FUqYqw0ZntcCFJGupgeLt85HjQLzLQKHyWqueKBqpIJ1gHCm5qyx0sOrryYaO3lIQaNce40mWcLKx8+/
x-ms-exchange-antispam-messagedata: 0/rpVOj7chyUEHygNolyDobTJxbtgStC8OoFuqGZ+IpN4bUCnP886tJk56IwHCQ57yGLrgjFbB1Q8/ElYTQqQaTifv6RKvcylU6m0fMJdyVMbwSfdgRKnWomgBaV7x5wbDAqOsWvaqpNwbT9CHU+ow==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f08644-fa4c-4ae3-c21e-08d7e2ab391f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 08:42:12.0893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9F8dpgiHt2vEyLhMRuJSleC1n9S8vUSNh4NCs8PUUlxzvTMIgPmB7G7+/cicwRke6EGHOPResmvufiZUNKUQApqg2lA8EhW+4vllP4O2vo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3678
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17/04/2020 09:42, Daniel Wagner wrote:=0A=
> Stupid question. At the end of this function I see:=0A=
> =0A=
> 	/*=0A=
> 	 * If the host/device is unable to accept more work, inform the=0A=
> 	 * caller of that.=0A=
> 	 */=0A=
> 	if (ret =3D=3D BLK_STS_RESOURCE || ret =3D=3D BLK_STS_DEV_RESOURCE)=0A=
> 		return false;=0A=
> =0A=
> Why is BLK_STS_ZONE_RESOURCE missing?=0A=
=0A=
Because technically the device can still accept more work, it is just =0A=
the zone-write lock for one (or more) zone(s) is locked. So we can still =
=0A=
try to dispatch work to the device, like reads or writes to other zones =0A=
in order to not starve any readers or writers to different zones.=0A=
