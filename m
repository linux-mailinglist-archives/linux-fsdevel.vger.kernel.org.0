Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2293D3049CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbhAZFXV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:23:21 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:27194 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbhAYJPX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611566123; x=1643102123;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=wPaNZM1vZ3d+d47pOpYeOndobOK6jBxEFz+/lfRvwFU=;
  b=Y5aFyoUqlPcQ4Db9Y1cqxOU6QVNLkf5o3dPIFmAqWBSMaMh9av+tdxdO
   F5XwXdpbF0+XQoBCzspShWB57+VlPlGML9Qe0UmejR1fI28LEBd6L9Hsx
   TDZOT5AcC2E6yDbt4h2yesa829gAZjwOeC1+o7uC8bBEKjDyd9WyzPot1
   INk68plRqdTVTyruI1BBxt3J4zmGxgZR/mx/tuUIHUpgUPSM+LW0i3y2C
   +THH2W66IbLAvsZupU/f3Vr8Ml+2j14WnJk8cSX3Qfqdc6djwnUw/FOJ5
   HoTlhXx8PUIIR/VfddiBRuq1MIEtq0yP+ortmKguTsA02Sd5UpKE72LhK
   Q==;
IronPort-SDR: ybn72KGwRgPmM3D4At6aKELwBv/6D2K41S2FIZvviTQGnvV8hb0WLolOkUBTEKJJ/W7Haow+0Y
 CKnasmSowkw7OVxVKsG3iHz6QdTupmi+zQgtk46ysWWiAr9Ie02yLv3HfntMQjIqYD1ynSMjbT
 eoiMmWDQq4Bio9m00WarXZvISZXM+zY6Q3AF8jUzi5va2Z1s0H0IxERPf8B2FP7VKxvgjSjjLJ
 f9X6TcOx1Ib9NF9e4PVapSSfu3dJDutZkuhYKtWRt5HGVOq2J5LOdFMkfBYaVBHmcCklK9wfiu
 JNs=
X-IronPort-AV: E=Sophos;i="5.79,373,1602518400"; 
   d="scan'208";a="158239963"
Received: from mail-bl2nam02lp2051.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.51])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jan 2021 17:02:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0+j7/hmXzUFpJfEvPyAe6Ug5Xn2xjdaJ725BzS9GyVTljkiMTu4lF7+sonPn2ciFrUZxS6HPpun6YdXtf7Sk0TbsUDSMBJ/ViAlzY3yk8UVr7V41/KwNAc6GR7avNc57PiwyBZ0Qe/jctJBHAE6lr8LByacLCQt4rOL6w8sF99srTe7yjKCNC7UetfdxUM0N9JuPh+Fx7a/Gn3dbI8f80b5pzsRrgiKTIbgJGXJK9HIKPHiD6vLtqYGBdV7fFtdFD9LGC5Hjw8aAD3UcV1bV9DXf2Ydv/xb08oh4edLLTOdYgawvYmpJHNbbyRSFYEjG51NUTwObZWI49v5JYHNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6W5ti7F0DEKeflpVd/qaWyOFiAf8XdEtshNR2ADxQU=;
 b=AfMW/MZaXq5HbU8Eb+HPjWTd6K9e9t6SPT8SMvoaXAI4kR9qyFE2mEJeKMW62j12drCMb9yllVu7Sx+OjX742xOwmg5NN6e+j3gldzhbSiirBjoBhfaUJ8PXKmGlzYIY5NyUsMNOPhROTK0jw2oSf+8fXSfbCjvGQSapCeXQ7cmDgOsEYQiejHx1wboPdqqzUGfpp+3CwoPTHO95T3D+YWuKYHsd6+dnlfNxplSY9ycMrrgar+IpN1d6AT1VDiIO9hUiRI3Y04/ZxUJFZgnz+F1xg8TU6LiR+3KQLZlmGJofGzR451RwzPFaCouEUaVAc4SNvfqWSQYd7JwJC7dY5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6W5ti7F0DEKeflpVd/qaWyOFiAf8XdEtshNR2ADxQU=;
 b=gtB28MFMAOKYMpEV+8lgIKqPFFpvduX5CN5uaWRpRvNOh0BPeaQ8DDHMHrb4cJiXVkTWYp9eB/y8mxyu209JUD+SknGZ4Au6HLIA4CEOrmijt/9uenEKW3QRre+5V3hpm6J0s9IIL0wSt0PYxZdmjMmSxOOwfQnfyxzfUvL5/8U=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5408.namprd04.prod.outlook.com
 (2603:10b6:805:104::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Mon, 25 Jan
 2021 09:02:55 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%6]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 09:02:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v13 22/42] btrfs: split ordered extent when bio is sent
Thread-Topic: [PATCH v13 22/42] btrfs: split ordered extent when bio is sent
Thread-Index: AQHW8IfvPraG/TW9u0miP5VLw5sG9Q==
Date:   Mon, 25 Jan 2021 09:02:55 +0000
Message-ID: <SN4PR0401MB35987DF6B8CF50F0AD68C6C99BBD9@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <25b86d9571b1af386f1711d0d0ae626ae6a86b35.1611295439.git.naohiro.aota@wdc.com>
 <e265540c-9613-9473-f7e6-0f55d455b18e@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5304d52d-f700-4ed9-8ae1-08d8c1100113
x-ms-traffictypediagnostic: SN6PR04MB5408:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB54085E2870B00D98553469209BBD9@SN6PR04MB5408.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K6hSC/i16ubVAawFvaHYV0Ug4+XwL3Qh6LRFuL2W1Z7zB1uDVvW3pj/dwmz+sXNbZC5+AuerktT9ew1RFBES62IPIDfRoBwxi6ossCr2HQimP0vYpIuH2udSV+DCb8NzB9kAYiIGqMzlSIr3NU35TBJT70c/LMIIY2H8X7J0wt23bQvyjYghlph+hBxR7ESeSjFsZdZoQSS/+4QagsCdcul9AKrZIdSsEXVN3F7Oh7cIFB1hxt2CqK7Eqnufgcx4vofxKUTSiM7jjKgkfiR6i0ZKeg7IMJ8Z4cP+AjRF3GqFNoxTk3G//4YZ41m6yfVD9yIGIrq9fh/7NO/YpqdqjBg8q4Wkhz6uyg6wA0r24kcd30Q0sNAEn/gV0XX4Cdf3Lo2rX3VuR9ZIol+5xRPBDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(4744005)(66946007)(76116006)(8936002)(66476007)(7696005)(91956017)(6506007)(9686003)(71200400001)(110136005)(4326008)(52536014)(33656002)(478600001)(66446008)(66556008)(86362001)(64756008)(8676002)(316002)(186003)(55016002)(26005)(83380400001)(2906002)(53546011)(5660300002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hUP+oozKOiLhJgjNyLgflR3SBUi558ciSalkTuNIW32VQS8u4P2h/ibRHX8O?=
 =?us-ascii?Q?OYmrPoMJgr4d5z9nNxzRxd8cd429SNoPk8G2+WVPodjOxDdirb8grK43iI8L?=
 =?us-ascii?Q?0e4tXORMrfcCd84ApgykK5NpOc+rIuyHBC9xCE2KJOtsPusgLLuhZRCRhVJq?=
 =?us-ascii?Q?P41FjJZYH3ehhtnczlDbmo7FSGx40GBCgWHjgcjKk84JTWpON7viSdb1gZqa?=
 =?us-ascii?Q?IeTJ7kksO2+8zUXyax44vo5AT4kcttBEOQT3o7fPHeVa0xAiXrBjteg+LGvG?=
 =?us-ascii?Q?hlrsfjXrMIgWZtd8vZrLSyqz7slRvvfCn16/GQXEY3nK3voyE8Lniw8kjajD?=
 =?us-ascii?Q?J9oLUKQ/dAe3kXSXxWUMeuVaS6WcFw/51ON0v8pvh70AFVTH1BcLq1vxKGRD?=
 =?us-ascii?Q?GPad7Xi+lmB4M4PDCjiRG5LpsCtsi+VaAQsBneT10wksRvphlx+q/lb8h1JJ?=
 =?us-ascii?Q?yurawQZMTAAw+ZxZHKF0tZehn91DqgA2BhN/ynUGdJIxoLmsG7awYjC2vR/8?=
 =?us-ascii?Q?Iie0evz/j+VMAdTyF+OeuBMZ4WXZfdemVqVpg/Aw3YyzFVenXMyKwK2m7Ja3?=
 =?us-ascii?Q?drGkCCiajetC74ImcrOAypg3Fe56y16CaMZGPatEFCXjnTrS4xEXCFVaLHd6?=
 =?us-ascii?Q?E4UbzQ1BEkHw4286/PNMw2tAgTdhME9caXPxoIPTU2qw1zgFD9WCCi6wGJZR?=
 =?us-ascii?Q?JuTu1ZTgrwTrJRn+fewGwXhOTP/8rY1pn456gbSPyR3ijES/zje8rLEXCNLD?=
 =?us-ascii?Q?r97iMchExdJtBooAeLFLrLqZRpz/SOBJyYZ+o6zAuo6z2rM7CIDrHXQxMNZC?=
 =?us-ascii?Q?0kjLfVnNcTjtGMkiIVrQd+OSq2csMylhg7LGXfuWk24Hu7KPjxslFkgihY7l?=
 =?us-ascii?Q?ijDuGaCi8DV8vVdR2M/Vn8VjfL19eUVTN72LagbD/T+JTZdbO7LFHrxdOnVC?=
 =?us-ascii?Q?9Pl+8aas/iIU0Z9+YcHJwqyjmGHVjo6T9tg3uGabR2uH3R7E+H3H6gu7IxFy?=
 =?us-ascii?Q?h6HB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5304d52d-f700-4ed9-8ae1-08d8c1100113
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 09:02:55.3371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 567EDgWT8pG0wjYJDz9fxPbXoXwHl7grySVNaPSxpyssCWhP0yUZUEHfq7XHISHlpei1b6bD6d+bcgleM2JbKMC5T/ufbGF9sV0kQgrxc2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5408
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/01/2021 16:24, Josef Bacik wrote:=0A=
>> +	em_new =3D create_io_em(inode, em->start + pre, len,=0A=
>> +			      em->start + pre, em->block_start + pre, len,=0A=
>> +			      len, len, BTRFS_COMPRESS_NONE,=0A=
>> +			      BTRFS_ORDERED_REGULAR);=0A=
> This bit confuses me, the io_em is just so we have a mapping to an area t=
hat's =0A=
> being written to, and this is created at ordered extent time.  I get why =
we need =0A=
> to split up the ordered extent, but the existing io_em should be fine, ri=
ght? =0A=
=0A=
unpin_extent_cache() needs em->start !=3D start or it'll WARN there, I'll a=
dd a comment.=0A=
