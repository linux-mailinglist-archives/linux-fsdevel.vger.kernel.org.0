Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B36381A1FE0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 13:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgDHLcd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 07:32:33 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:14046 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbgDHLcd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 07:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586345573; x=1617881573;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Tw41quE27+FcqToxPw7W6Bnl09ZSNYM+bmNFMNaBaro=;
  b=VLogq0/r5f1LIfFehqqUia5GfXQWjiHug/pb8sitkvjk9BNCpyHJRWBq
   2Xj6JFwxPWqUABkNPo3yaGzZqbscG3NXm/9RISVbT4+3YX8RUZwu5rEpw
   jOk3hnMBD9nSpMx5YryvRAMTCiNNa57f1JeBD7Eh6QiYPQxN/SIBbv7z5
   9/A7agIBm153IjJcqmy7bwBpWNQs2S/qM6BxHHGaRn+UzlYxz5Ku4y/Qb
   88NVE/IdV3QxdOHo+At59bLkKoiDtadhnoZhQrSqEWqTKhdG9ituCL0qP
   b4mVzgVOAMwuvliC4D4cw0iySnDtR+LioWmDGdT/TTfuByLCAlIbqmIlP
   w==;
IronPort-SDR: j1KJmCwvydr6ojhEsg62KyFuKOCJq+URbHRt/vloMUHz04l3wqxIeisxZ6aoVrlbmy6m2YldAj
 E+/3EE8wdoOni8uIfjBCMUGT6Xg602Pa8DdySVTBvWqRW8QLxZD6q3fEZfGGdSzp5HePv0U9J3
 fj0FbQNMJMUWDU6d970SVKEfcCIS0jjT9btcmJEJNbsj8ZGUa88O5GnWfXgjcX0gOxnrRiK73m
 n7DNcplb9llx/TDtiej1IKRfBfEm4bozCch39YxUmB9XqtnkSJstQNugxOEnu8QKQbUnNoUAqL
 QBs=
X-IronPort-AV: E=Sophos;i="5.72,358,1580745600"; 
   d="scan'208";a="237196737"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2020 19:32:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knxuQOJ1yZ4tH/pKDc1CA/8ZNJngG9gOaq+Q4n03eeDEdyGXi4nRn5FeZjpzm5yadI92JTTeLorFpLAJ0fCSW+mZsFsG6U9cWnKYyuLYJPGAOs9OI7FWjWIT+oUG8Kr05NXmEoEyvCAPa0UjNr2XIDVSmlULm8YRXLfQpqeXQz5DMzCtDu/3k68iLqOAyhXAVk4QkY1L/aRLQIQSY7fWyZ5PH+JCRircMaE3U/9glqOYBX5E8B+Cm/i1R0rSoZ+Dt/8b+6aBkm9nulEepKOoShh6RQjri7vngqV3BQYJ8GbNpDirgA+wwYPmCD1O6p/NhRjladlNje0PmyMGl+LS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piCGdhmyKTmh+zXIAj4s17hamobS/f/ygCIA+ON1TOM=;
 b=Bjhnn9Fg111me7KTZGycyAdflD3kacYnXLyQzvq+g4NPFRj74FqaGW7Jr+YmiddaXvg+Z1bFj0BVtzawpK/AxkB/V7KiuM/crYho4E6nw8SaZ09mLEsdrU5g1rQX3kHE/74dvBPK2XAoLpHCuuQ1QkilmX5DJVQHca3w3sr+dVRJXikZZuEiDbf8QpWkD55jvm9Htn+cTw1vUqW+WIYTM3e8lhgtyj1yJTxTmf45nRB9j2lXlIFrPXBAzVsPC7yBK9DrpOLR1/Q5N1eJ3Oc3EBkIsIbPkVsztR//anp0ohrTmptyfdopNoUFwmhPevHLJW74xK+VzmBFCLlxnEY0Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piCGdhmyKTmh+zXIAj4s17hamobS/f/ygCIA+ON1TOM=;
 b=kQeHV2Vnk3MysSZnefMAUDPvxqWlTRV4EnaNnFmHN4kSZEqvAtDUAo4Ce5MnplmMrCrNXtPxTdIMIakkvcOr57OXIyQsztpA1GnCyKsBmnByVJkN83yZLyNjkmEFc/g5KOR3uK/1yQmSPNIqRE39LipemUYMhASM/UlCTGncWyg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3535.namprd04.prod.outlook.com
 (2603:10b6:803:4e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Wed, 8 Apr
 2020 11:32:31 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 11:32:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 06/10] scsi: export scsi_mq_uninit_cmnd
Thread-Topic: [PATCH v4 06/10] scsi: export scsi_mq_uninit_cmnd
Thread-Index: AQHWCaB+r0BJcUV2vk2dBDMa83deYg==
Date:   Wed, 8 Apr 2020 11:32:30 +0000
Message-ID: <SN4PR0401MB3598D625922E9EFCC2F039F09BC00@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
 <20200403101250.33245-7-johannes.thumshirn@wdc.com>
 <20200407170048.GE13893@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a37fd4c-127f-4c70-ea5f-08d7dbb08654
x-ms-traffictypediagnostic: SN4PR0401MB3535:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3535897AC3660BB84D1392D69BC00@SN4PR0401MB3535.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(2906002)(186003)(81156014)(86362001)(76116006)(66556008)(5660300002)(7696005)(8676002)(316002)(66476007)(91956017)(66446008)(81166007)(53546011)(64756008)(8936002)(33656002)(6506007)(55016002)(26005)(4326008)(66946007)(4744005)(54906003)(6916009)(9686003)(478600001)(52536014)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nKTzdELW0Io/7KVZ2Bq1DlSLudGpbzhAWO+XOaUseTUxWdoApd1CX1wg/tvfR7BGKV3ttiHpzhi5+OVjs+ti/ckRFqJxEbD9cM9f3SrjycOPAannRO2PSiTjHqURR4GITfDthVc6U5g7UpJAktSC+/Eyr5POvL04pHyCfWKz1L09kw/uiK1eZYPT8k7hZ5DpRHYpvqUQV0HXN0rxk1AFNvkSM4kFNJ/L8lOTqnvu+N+XY3Jcv9EH+LQMs1/S9FABoqmAEiQ+r8Sieyx8FmKmLGd4bZGz4Mj4PwHzPKhTVqWkjsCW9BcC6RObGjDsYv1lNvS2VPVu0/OgF86KRKNjUZbbBtG1Wl0JCt2Uc5sfjMYySfWLBwEw7Vs3l/YZsYJq6wJNmOk6NOV6k+paFJ1vOqu9vC53/6pzSLtfE1MFpq8nStzfToYv1TS8ArlVL/2B
x-ms-exchange-antispam-messagedata: Fnn/2ZE3tgYYbtjz25DZ37FlKLARQ4fsSdUrSVvTXnHa+mG7PX4GcbB1caZ8FOnqJHTYeXeGCSiTaHR6C2XHGQ/yYhHeLD5+ZZmwR6Cn98vVqguACtAp7ZuEPuvUCbXox/yy5k/3E+rfHAb5AX5RpQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a37fd4c-127f-4c70-ea5f-08d7dbb08654
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 11:32:30.9764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iltsmVnWqwuEh75HjhrvfLPAfg+ygfeh7s6SlG4FzTtOMbSLaOIb8+K0r5wXY40tVpzL4toI85EfyxRoow2NV40KLehYnWZ2WPdvqUWxtj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3535
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/04/2020 19:00, Christoph Hellwig wrote:=0A=
>   - scsi_mq_free_sgtables - yes, this would need to be done by the driver=
=0A=
>     and actually is what undoes scsi_init_io.  I think you want to export=
=0A=
>     this instead (and remove the _mq in the name while you are at it)=0A=
=0A=
OK, I was afraid to expose too much internals if I export =0A=
scsi_mq_free_sgtables() but, sure that's a trivial change.=0A=
