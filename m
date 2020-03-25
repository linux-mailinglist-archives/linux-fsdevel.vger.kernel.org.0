Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5FF192E1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 17:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgCYQYK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 12:24:10 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:23348 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgCYQYJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585153449; x=1616689449;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=nEzd5oJhug7Jwx0NvWzMWqoR1WZl8Z18RwOJ+q1i8y0=;
  b=QbiuNsU9hZL8MVt7LDczmd41gAdC4GdKG6fT0YbACInB3tyyGVCdawZ3
   em3PU7gRmG7b7bOk8uAIp3Ma31I346gyYyRAjkcctfhDPFcUdZTzrw0J2
   zbBngWHOCe1fERm4boE8pZmHJBM1QiiBzq81EiGjZerDOM5Obv8VuTnXf
   sMmIXn2xkdx9QRYMxdu1TiZDuMiYiAbbSwzszRq7UqadyLVr3Cgi/EbZD
   ur3KzDXs+3cF//mVbIWNjKZp7hVER2/W2fTIgupBnp0ypojPT6+YfWJ+S
   06JW33eqhBNSkbjZMslAGrmFkS4U4IGLLIrhrhHhEtiXyMahUqVbr3VYc
   Q==;
IronPort-SDR: di97H+1McoR3IrkT0qGBQt8Ut6u7z+bqrqaPDD3YlVRk9Z9Z2lwgQJPNrLV2IoaxbgJIwIZUGQ
 WqqVgKdPhHz6wJ0WSC/RnLhR5JDTIHX+i/b2q2NWDtVXayCuQ1fRV4bDhSwlCeIqtJcVldiBTA
 z+QoRAXzE8Gn5m9WRV+OPDlyHeUJFWmxZPSOOO99ytP8IgTHzczKijJihpYN0KvZicJDRiwAus
 HEi290Z3NIJh85pW6QyIbWxtFDXWYhYWxgr3VOvCT2NoIJ8JWrBjkzxgiYufXWX6oEaAEMmCN2
 5Sk=
X-IronPort-AV: E=Sophos;i="5.72,304,1580745600"; 
   d="scan'208";a="137865847"
Received: from mail-sn1nam04lp2057.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.57])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2020 00:24:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyMo61kp52C4OH+MzmAX/EPzNuNMFfuHvnoxDgPeifosSoX4JY2kwbKlplkxBl1gxE7jec972C1tXjw/npZkazkEmsmf1fkgZL2qrRxdsKEMSuWJGeKgOKHx45y20v4O3pGQ9q8tutRm0/IJ8nDA60zb/9NikSBUM9bxo9jAi0afwHyO+p4at1EDXmSfOqv2ZoeLfMIqJeDYI71d0Gta5XLobnc2t2GB1qvStiwkhgu9KKN0ImCwHYaJNx123CbFRtO583zf9vuznJtQ14g61AESfU/M5hTzuowhvsZwMKdasOSvFLNlXcLvD/pCacJjgHrjbsvFeXOhYrrD1LQwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vkxQaYPjMcWuUuTM4hP2zzHCGrwhBDyr5aSbrY9H38=;
 b=ZYHnXo0x9pRlvF3aDnBkHIIo0qOM1kBfD4TsMuyjUi69rbUZWWorOsglEEagnovdGNQFQh68wDK+4koEY4oIL/KkNpxwSmmijdgbuetseBrvHgavEXjg+F19nXdHZ4gp49XxeY8tY4oIob7AAy699KbczS6eDYdxkw3plyAVZJlky0u5APq5hcVDsvqlP1PQau6uwk7eBAG2WBfdna2IHAsMnAy4WoIGQCfLO17ULMkJcwdDm7Z74llhXBjbBQmRVdJFVP/FbaHLZcjQ1M0LnLT7AlxOdSzdknKiqp0beumQ6wVqktJXeyYwENOvhZA7OHAmfUCbsR4+eFBufnsHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vkxQaYPjMcWuUuTM4hP2zzHCGrwhBDyr5aSbrY9H38=;
 b=JvVvXJlmWRGUNsZKYHrffFzNVCtRCNtFtugsmgqVbcIysTKoSrkcFqH26LyDQCSDQQdgIs23GJUNMOKhsRHEZBZzbpAgbxNFzcgdoGRD4ZLQ68LisHoeKNqAJ/L+qvsd3JxYZiDCDESVFpOctefBkv+KNRnVAABKc8LVMtcgpfU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3710.namprd04.prod.outlook.com
 (2603:10b6:803:43::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 16:24:07 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 16:24:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2 03/11] block: Introduce REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v2 03/11] block: Introduce REQ_OP_ZONE_APPEND
Thread-Index: AQHWAfBskP1byqASXU26hlsR5DkSLQ==
Date:   Wed, 25 Mar 2020 16:24:07 +0000
Message-ID: <SN4PR0401MB35981508ACB7533C8516E9989BCE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
 <20200324152454.4954-4-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15dcdb5c-aaa0-4538-2ec3-08d7d0d8f150
x-ms-traffictypediagnostic: SN4PR0401MB3710:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3710B8EB95518B43DF033B569BCE0@SN4PR0401MB3710.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(9686003)(2906002)(86362001)(6506007)(316002)(54906003)(33656002)(4326008)(53546011)(55016002)(26005)(6916009)(7696005)(186003)(66476007)(52536014)(66946007)(71200400001)(66556008)(8676002)(8936002)(66446008)(5660300002)(91956017)(81156014)(81166006)(478600001)(4744005)(76116006)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3710;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tNhGvDnYqxzvbIqiLb2gls/A+OMy+mwje1J2JnCK2FSnK90aGKfBk5m+4xiH93kOC/oZgDv/yfooaVt4oEO0Ba1LFhjcBvOf+4ui5qtkNc7Vph8gsRtJUC133GyBmDx1EOJZ5M8MlODm6e6DLs+3zLKBXfJ9hGqYeZLiuGKuKl97Hg3++BLj/fbU6W6Hi4GCBMM8LnXYUWXD3gPlxd+eEH9Ib3jyhr9ch8nd3Y/L9Kq0XsNeBvEy0I8qHIpDq6vdg4XZ6Ug3toU5/lAnw8holb/0Cvsbhu+l7mbRZyf+Yy9InDrqgwbcCZbCk4DyvA5XzPkM4CV0bincXe2j748Pb2hAc8orKx0hUHESPlBCUp9GeNfYGQ2F7mlHBWNTPzkGnkhWepURU0yHKE6Dy3JhB7MCNrVi9pEONMXX1DJZ8UmIT/Hd/L/QWN3MA3C2rNl3
x-ms-exchange-antispam-messagedata: O4HIxgO7mq0DIE4nqHTFb4StemvRhCwt0/c5vAGNgNJfFF4mqUIrDTP71n5BT8FjJ2lKRGnigUZMTJFUDz9sj7MKal0GB/H/soG93WKe3VwXHbOj+3ZhOAkU7qBeK1TEIVe+0e9G67sWm7D/5+yBCw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15dcdb5c-aaa0-4538-2ec3-08d7d0d8f150
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 16:24:07.5422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8r5JY2HAqKHZ2Pyg3YDzmWDOGSbLIWIbQdy6ReMXSg++twviaTyPPpFBTIgyQhCBWt8Ou5gEQhP6MqobHOaZf2Q65FkwGcZ4rNUPS9o/iDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3710
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24/03/2020 16:25, Johannes Thumshirn wrote:=0A=
> +static inline bool bio_can_zone_append(struct bio *bio, unsigned len)=0A=
> +{=0A=
> +	struct request_queue *q =3D bio->bi_disk->queue;=0A=
> +	unsigned int max_append_sectors =3D queue_max_zone_append_sectors(q);=
=0A=
> +=0A=
> +	if (WARN_ON_ONCE(!max_append_sectors))=0A=
> +		return false;=0A=
> +=0A=
> +	if (((bio->bi_iter.bi_size + len) >> 9) > max_append_sectors)=0A=
> +		return false;=0A=
> +=0A=
> +	if (bio->bi_vcnt >=3D q->limits.max_segments)=0A=
> +		return false;=0A=
> +=0A=
> +	return true;=0A=
> +}=0A=
=0A=
That return values need to be reversed as well...=0A=
