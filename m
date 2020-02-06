Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7897615484D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 16:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgBFPnO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 10:43:14 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:65006 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgBFPnN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581003793; x=1612539793;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ilsFRuSBIclhWGUN9rDbszXW5Ye8u2qGQBA7Vq3tznc=;
  b=fe4AEg/1fAOETHoAHZI2N468Z5QEtzBI7luOQtoXeme4QSZaWtFOJxw1
   8DoAtTBqKqtn3XwMrUD5qykcpqXQ/7JmAzU9yS1R2KeE4VDC+2EiJoaPC
   x0yrt9g/hlAx/QxriIA8wx0rD55uRfG0dYT6MKRtueM+KEN6Qu59gk3DS
   Xr8BQBG5p47PV9L126ZlBL/9Nnq6ZzPKjnAq/THGLfFdMO4PUVMTSXV9e
   hxBsiHODX4pADL6wd6xkPWIbLoqZcxqucRdAvpegnDNDVCd+du/zjxaO0
   RHYgvUxrMkbZwOcFdM7eoeK6D4E0BsmpgJZlWdikIwJzjIkiLHrwlvB+O
   Q==;
IronPort-SDR: T2HgrStMtn913HJQIfGeWg/uWzunzyXfrNH+8tow92rbuJhr/fVhLjhg9OioAWwsvJBtMoJgAg
 nuhCkUkxX1/YRmfzkZqIkVthyNKwfNCiRKWmmMqEexGS+YNlbMTSdcfEzuTcShgq5H4DRVRCh/
 nd7IGPrHNPnNwnZURdbPM3FsdrEoCfRWhjavQT2PIOKzdK/vDHRVt6pXEfhwKi25rE0nP+MU39
 8M22jPyYJCl98urFXAfhFfTV4eJgEvhEK8kct1/dBU0VPcOhqZwZNAkHM0AE6po/rjBnzURZd1
 cGc=
X-IronPort-AV: E=Sophos;i="5.70,410,1574092800"; 
   d="scan'208";a="133613193"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 23:43:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxOyW0H3g3wN7w0jKVcS+9Xn/o+OL7GoluWdkl5uUQUGj8//vJbfcLHxeNOGojtuUmAkFTQypehoTJMDtcuGaKQYcHZgQzgfKPsI/NYVb+oexTSZBdDRagAIjDaAri36bXA0XaBkPHA0B93JBeaiSGOXqs/5DCV+LZWdJC0VECKKoUuShYFZbvr9jaNuhXPCfs3zU1p7W/aBoXcD6CNywNdVpN4YOH8lCn2qR2FW7lFhB07VThO/yerhkxuOzFI+e7l9ld9iThmIt28yCUIFnLNhH2Cs1pru1d0AWP1DW7hKpnu2vevpCI+C0Tna8pwpfezatCTz2ZS1DoYXts9F8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIVAhN7u20P2fIEeQkul9Q6+u+xeZXSMPYZ8/0Rb23k=;
 b=Xyk0OWzQER9liE4vsRZOFPwmQjPw/KvwJqJDSgolbtxPsAKuVDqSdIKlhVmPihzZVPN4nChfDSPbZ8F4CK7LgTyQXG09z9yTdzgo1hH8dxFlTi8CKzChlL9w452esPLCitEOv04EgAFfI8ADns4zM1qLGJJjfy67y+RwG95Vb+oYF3xEDF8TVYfx091fRhTWNAYIaPT3383gUJVGV6w5NnNB0z0QJX3yBjOxxUfU8QyLy9zIsJSIqRRUjtJHM8EGNffvXJjOdnZMTXQO//rVJarBs2OIqAWOknK7wQpBThO6N8engAO9ZcGwZncK2GYeyaWaX0tsyIjFGjCkx6Gc0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIVAhN7u20P2fIEeQkul9Q6+u+xeZXSMPYZ8/0Rb23k=;
 b=UQ1uZks78GIK+KC7HEWsGQCnqShwF9YHeUuGXGq4/B4Y2QRDmz7v+6AaDV13cxbkdw+BMXMSoP3KWRxZP4dkkRITRryztPxChn1qWvUIbglEH5OQ7JelFGLBurvhgbjuzhbnrfQo6R2Zltr38G/MFZWU8vNxKEC99wN/+Kj4qwA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3631.namprd04.prod.outlook.com (10.167.141.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 6 Feb 2020 15:43:10 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.036; Thu, 6 Feb 2020
 15:43:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 06/20] btrfs: factor out gather_device_info()
Thread-Topic: [PATCH 06/20] btrfs: factor out gather_device_info()
Thread-Index: AQHV3NprfbSNZ8/YvUyBGXFoTfjQug==
Date:   Thu, 6 Feb 2020 15:43:10 +0000
Message-ID: <SN4PR0401MB3598D4A69FB9C890F8C25D999B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-7-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a916a2f-b52e-4e35-0090-08d7ab1b4523
x-ms-traffictypediagnostic: SN4PR0401MB3631:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3631203E366E263629A17FFD9B1D0@SN4PR0401MB3631.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(199004)(189003)(55016002)(186003)(478600001)(2906002)(71200400001)(91956017)(86362001)(76116006)(8676002)(7696005)(53546011)(4326008)(6506007)(9686003)(26005)(558084003)(110136005)(81166006)(81156014)(5660300002)(8936002)(54906003)(33656002)(316002)(52536014)(66556008)(66476007)(66446008)(66946007)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3631;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2rzY+uVfS109gHqpCVBLZ+Y6RkqrP7BN3p3lYuKM4BEa8T4/ixAxCs82Ul7jnFgCrZLpKn9tX2a+CxlXi4w+r107i2r2S+SAGZ7Ij699sdtO12pY7TAwKFPgOAsJKHMJ7GdrXtFrxO0HGWFvvajN71Th2DLgOLGo8zMTbzVr+0zBUu58V404ATTRnQgeu515SvpfVEmioahULZP+C4IXtcjQC+Sm9M05YhF0Z2VyNDa5j57gll2vqD/bY2aOAOEcWzDIOUIk4X/EGSPiFISRajLBCwGN9j3LRcqORfYdsqcFORY0iiad2EmCc/+GC8G5IGczUGFTuqEhk/jzGBpK/keCwOoIE1ZIv0+JxXG5wijVWfMHlCoT6davbRsC6A5pu7mXQSzGxHDJozbmFTq/2/a5Rlq1JYdGTjco9e++8j6hvBq8ndBFjj9H8ATy3Zve
x-ms-exchange-antispam-messagedata: 1T5p+b3XGlD92QuoUAjvvbAGrTKjrqp6q+qGrDWTguuGrL+i+lVGwgJqWZ3/9057Zl5jWQF0PKXn1MYtBcrwUd9EjKXQ/tl4O8HhP/Vts38Lci1s1dMEiWlxKYW6PrT+1CDsd5nRfYx3+Ovx/H0SvA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a916a2f-b52e-4e35-0090-08d7ab1b4523
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 15:43:10.7543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oXhxeHAgrgl2rsJjNw+tCi9lwvUPDkLJVeNBxVNMqgGZj+PNUa/2NSK8hW361pASLw/P0jHAQ1xazk8FVrawUKbcM2aVNYAcS5XQCXoptjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3631
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/02/2020 11:44, Naohiro Aota wrote:=0A=
> +	BUG_ON(!alloc_profile_is_valid(type, 0));=0A=
=0A=
I know this was present in the old code as well, but can we turn this =0A=
into an ASSERT() + error return?=0A=
