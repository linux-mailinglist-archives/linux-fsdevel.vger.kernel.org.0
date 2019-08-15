Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C74A88E54F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 09:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbfHOHPK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 03:15:10 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:39928 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730546AbfHOHPK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565853309; x=1597389309;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=KUso+9Dk7rmh8SX4lRZBsSm3ZNgBtTM/Aj/A+mdWAQM=;
  b=SFSO56IUkTdg95wG+5Y2K/OJGzZYYf+bIp5fGQ+kmT//K0AZhC2zrMyH
   SaOYWs6UjCvlwv2vwL281JSCHUqa3arMgbkGgiNLe36OAYBuY8i2AkcnA
   E2aX5oxpJYLa0nKoVJyBHS0Un7w0SbJJy9K4xQwVKOfXX3CGiig1z6hkY
   TK5UbEULreRSonDo4yEUdhCCqKhs5Qlno3H1d06XQw3ftYINU/GS9XCfu
   oWghZvfJIptiUH0sAQhPBPbbcsFrs+7IBSTI1U7GAWKUmmeI/u2SG36bc
   JJ44ZI4ZW5xxhB6dyh+1RkDBY4ghP5y2BoqfQVXJZ1a5OJ0Rh1SafLtIU
   g==;
IronPort-SDR: M8VARG8XJ26irO/lf3IBB/YadK1nmM/Z9UXsiFCvxF7gOjZLKx8alOBHEkoWO1cBzCiUcDzc4D
 V4bGYe18N2D4RAQPvPWskOORjzvthBCeVQrAiDcszQIW7w32HwnFazkUkRwt1mOl+skCETnNv1
 2dVsY3xESlxmkCae1pHoxFoaM3gTKd+QrszAdp0pZKOuMTP1kiSsvfdiiwQpq2oZ4sGcnhWd0O
 j0DHU6vN6LYxNmYvXVbEeKwmQQ/eJZB+uOIiRJ8NTHXozvPVFsRTHe/QJhzm+1RYrU3FjQNOWu
 2Dc=
X-IronPort-AV: E=Sophos;i="5.64,388,1559491200"; 
   d="scan'208";a="222407499"
Received: from mail-bn3nam01lp2051.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.51])
  by ob1.hgst.iphmx.com with ESMTP; 15 Aug 2019 15:15:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npn2gcjlLaFHFkHD9im8t3WhHvaSrmkUSX3LOBTaBecxiGCBPhOMNqw7/6Ufq74GoFSgw0e4BTCrXo1ZXtrMSu7ObW2GkUrgm6ZJ7Ce2x5GqVcjsMymM6XWvZMEUq2aOlR/CfrQEaxzbqx5Hz2pFm2dU7WJI+3+Mw9pKdRpQc1LC4U0H8i95QPWIdUUAmsiz1cIAdA4MCjF3YOHVn8QkZipgAcwrGZJk2WWzP8Fgdd3bAwHeCzbRXdyUtqRuYXOALZEpiFlYFEWiZrY6KR1O49FJbfQGFjcntBkWG7cJB/LmJrsaxKYBO2+Y+TiYcP4HZ0SvlKQKNWuYOiJgrlwBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMBeA0esIsAZqqrINntbOGRh/TALDFkzapbLGKeUFSI=;
 b=I1rsL3S5Rj0ma0Gqx3bIXZU9iBac+t2lk15bWWGdpffzfjr+C0rDF7u2FaTu/VNp7+zbXKjggHKvjpxJ+3pCGru2GGVCuB8AsdASMZ9RF5/BC061Ylq4iggGvQg3W5+lckpHgd7eTtNX4wpSJb85pTf/ioFG/6DO5TVnJ5ekgtmjK2iagkPLzOPamG+UFjeELlnyO8gHrGV4FdnTGwAyYwnC0OQbqN8loZBIi7b1R5jeWqozSlBSktQRhxrXY1eDxozGOPtjD4KP7j590M/AYc2xgNAue6hdcem2Uzslg82BjMOjDW3cDAeGrhwkZz0jqYUzD/Y2lEUtEn5xsfrJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMBeA0esIsAZqqrINntbOGRh/TALDFkzapbLGKeUFSI=;
 b=cNsogJ/aaPZfOViwneycxAWovfmMzYL1ZCNBKDXKyDZ6cxupLz8D7CEWbWtsnIq00PCODbJIFBw18HBNA8eJcDMCsjbKFHPFoS61KeKdzQQa5ie9K0Tcg0lCc+Er/s/HlFuqF4FqTMhnHdgXcDbDuEGAtB19YN0OkU9Yk5z3KVs=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4407.namprd04.prod.outlook.com (20.176.252.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Thu, 15 Aug 2019 07:15:04 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::b066:cbf8:77ef:67d7%5]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 07:15:04 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Max Gurtovoy <maxg@mellanox.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v7 04/14] nvmet: make nvmet_copy_ns_identifier()
 non-static
Thread-Topic: [PATCH v7 04/14] nvmet: make nvmet_copy_ns_identifier()
 non-static
Thread-Index: AQHVSMM4pgNQfVl62kW+URoU596DzA==
Date:   Thu, 15 Aug 2019 07:15:04 +0000
Message-ID: <BYAPR04MB5749D194F4AD68F5A8CF0D5E86AC0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-5-logang@deltatee.com>
 <43951ad9-873b-5bbe-b627-0ad4610fbb11@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51c98259-0cc6-49d4-088f-08d721504b6e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4407;
x-ms-traffictypediagnostic: BYAPR04MB4407:
x-microsoft-antispam-prvs: <BYAPR04MB440738ECCFE4479030B8B00886AC0@BYAPR04MB4407.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:178;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(189003)(199004)(2201001)(2906002)(229853002)(64756008)(66446008)(76116006)(52536014)(66946007)(66066001)(66476007)(66556008)(2501003)(53936002)(25786009)(4326008)(54906003)(99286004)(110136005)(316002)(256004)(486006)(6246003)(476003)(5660300002)(186003)(7696005)(86362001)(71190400001)(33656002)(446003)(8676002)(71200400001)(8936002)(81156014)(7416002)(478600001)(81166006)(76176011)(74316002)(3846002)(6116002)(53546011)(6506007)(14454004)(305945005)(102836004)(26005)(6436002)(55016002)(7736002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4407;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lwjNeF/uT/1JpqBqZ4VE6pOuXQbshGpNAZPerp+tQO7MeUBXisXvno3NadTBaT+udQq1Y+Ckd+iNFihIzolg8mcdp3cFqME37y1YNQDdcJUmA3YTVIlsQNnZ+i0mBeW3BCjgfVtUSc+70i6PuHwrqDSfr3aGwNodM72JLU+7SJ7zG/iAScqJNjTiNJQpVGAJUKiUoCzIh0e4Z571cgZoLr1Ev0Su+bCAlLno6DL7oV9NMdOqqG6VOY8XYgBNAPv9hL0WhV3/9I3OvE39CPOo6hch7NLsjXFKq4A4geg+Nnuryh13Ca1NIEyZBdxCl0jo8zk5DOgUdO/xRKDIorpMVcWgq1RGlm9d7KQKV8wTpJ7aXjs7iyXZKHh1H6KniWCXpZcDEaiqJyTKu+OTrBgmPiGFjal26Hfyyf+44PQwPTA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c98259-0cc6-49d4-088f-08d721504b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 07:15:04.0838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qx6YQQH+tenS4yDfC4NGeCoDuobMNldYnG2oh0j3w0L0XeWY2qYV1e0HUwigvuuXJZbsTR5froCT0hjGCckZs4XE1sR/yf3VLGxY1mPWfso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4407
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/14/19 7:30 AM, Max Gurtovoy wrote:=0A=
> =0A=
> On 8/2/2019 2:45 AM, Logan Gunthorpe wrote:=0A=
>> This function will be needed by the upcoming passthru code.=0A=
> =0A=
> Same here. As a standalone commit I can't take a lot from here.=0A=
> =0A=
> Maybe should be squashed ?=0A=
=0A=
This commit changes the existing code which is independent of the=0A=
passthru code which we are adding. For that reason I've made this=0A=
standalone as it doesn't have direct modification from w.r.t passthru =0A=
code.=0A=
=0A=
Perhaps more documentation will make this clear.=0A=
=0A=
> =0A=
> =0A=
>>=0A=
>> [chaitanya.kulkarni@wdc.com: this was factored out of a patch=0A=
>>    originally authored by Chaitanya]=0A=
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>=0A=
>> ---=0A=
>>    drivers/nvme/target/admin-cmd.c | 4 ++--=0A=
>>    drivers/nvme/target/nvmet.h     | 2 ++=0A=
>>    2 files changed, 4 insertions(+), 2 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin=
-cmd.c=0A=
>> index 4dc12ea52f23..eeb24f606d00 100644=0A=
>> --- a/drivers/nvme/target/admin-cmd.c=0A=
>> +++ b/drivers/nvme/target/admin-cmd.c=0A=
>> @@ -506,8 +506,8 @@ static void nvmet_execute_identify_nslist(struct nvm=
et_req *req)=0A=
>>    	nvmet_req_complete(req, status);=0A=
>>    }=0A=
>>    =0A=
>> -static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 =
len,=0A=
>> -				    void *id, off_t *off)=0A=
>> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,=0A=
>> +			     void *id, off_t *off)=0A=
>>    {=0A=
>>    	struct nvme_ns_id_desc desc =3D {=0A=
>>    		.nidt =3D type,=0A=
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h=
=0A=
>> index 217a787952e8..d1a0a3190a24 100644=0A=
>> --- a/drivers/nvme/target/nvmet.h=0A=
>> +++ b/drivers/nvme/target/nvmet.h=0A=
>> @@ -489,6 +489,8 @@ u16 nvmet_bdev_flush(struct nvmet_req *req);=0A=
>>    u16 nvmet_file_flush(struct nvmet_req *req);=0A=
>>    void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);=0A=
>>    =0A=
>> +u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,=0A=
>> +			     void *id, off_t *off);=0A=
>>    static inline u32 nvmet_rw_len(struct nvmet_req *req)=0A=
>>    {=0A=
>>    	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) <<=0A=
> =0A=
=0A=
