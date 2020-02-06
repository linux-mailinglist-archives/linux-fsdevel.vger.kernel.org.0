Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B70A154573
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 14:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgBFNvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 08:51:10 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:28380 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbgBFNvK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580997070; x=1612533070;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=KJLGEGsI70/1dPal8aocJujN1ugBkPHzXQ3kNFZkkPrdt9g6jjJU2vOn
   Rgqfut00GQN3nGVcThdLQDkdkkWtDOR3aqb3mDYkt0ICYP2GPuiQyLinF
   fzxVXFi2IGcuDsvmqQ+prRiIc3lE6eCzVpCK9dyV1VoKivjCnxD/J6C64
   ThOGU7fEPozK/5OEsGjlXeORUK9608SMlfUjZ9cHB8wQYsyyMrbjua0CX
   xFeC9AJIfUhIEJAdSgm6js4N2En2yNTJ3ZBOO7YK6M0sE/vkKcd9FOSpY
   mPhG/fBaY3y//INg4IgGx1FgJi3dYG7fjgJCPGJDLn0FPILg58TD2PbWT
   A==;
IronPort-SDR: akge97sQfVmpmtcHXtT21FN+Hih1E46AMxnVY7GeBVR5md0jpU60dN4nd1SOvbCUAXouDdofxU
 wwOyN5/yNTs0F76eiKCBXOIoUDQIrNLlqRlyDU+0iTwIircU1Uey1litZiFaiIgZIRL7axoXLa
 AssuR2eO8Xte1QdzhAejXzy2T+LqcuaGthahaE1/HVwQJoSa5eoxw2OYV+GwxQOvFEvjPMs166
 hPN+ePR0UOgIha+okAptFoSpQ2kObEaGVoV/mt5aPBKXASoOiBIT9lJ+p4po83APF3LvLcWm3X
 E2g=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="129802012"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 21:51:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKHm+3bI3fCTy1aRm6G+SegoLQZi1Zpw4UqbyIO7QoDHXpeTNm3KBScbkrZM6ukQ4lFhm5cGc7j3bZ5d4upSOWM5+cTEjfe6H8aD+/IFjU19SPLcI+Q/LIcWRI3hszFbUh7l+SxWUsiLPbTFxg/uSzZmz6by+GIHANWmdQvm6CcXuapMgpS/rvtuvKYqdNf9W6wPwwSFVKQZaVN83o0B1l6/I1x0UEJMG6wU6e/q0lfQKauPAsNFq10w56HO6b2q4cbmKLTweynmKW7DGs+vDl1kHuiGm0obFmbjJVWX6J1tJ+TS1dqwrLhIhB8XxkCd+j1elKVrRujvpGWqmitc7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=chhG/0qk4szJY6Ra+MpFf9WikdHs6l1oqlWPIxDgFnA50Avt2zJiSOqXZIxvmEQ5DIriz3q4MrHGjGEh/LplChztGx8ooZeWF3vfYlrpYKpzrbowEMmTSKGB7oFaZb6nxuYirNutsviP19qGridwRA1MaT8gCaU/6xJMTpMMSidDAM8OdJpfYePv/yKsECbACYURMsg6PRoISeQ29Fj/P3t5N1ChMOFG1RLvVPvhMELU68b5wR2OlIC2ccW90/zN+3NWaNn/hk5YZPy5efDp+QNHIYx/PpsSyYSOOLYs4Zt7G+FPfYCcAeaifIS1gDfR8KziQC/o11l/hHhs0EN0lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=bvU3Wh2ewD5ddwg7nvgKc69dHZINwPXfxCZHr+Iqkz23xMpoPYCjlJN1TY8ySj3wn1GWiqPGVKkoxRf1AceOsOf9TaPMGykB3KGdodosbwx3wG3thRWbh2jnF3vi2dqwKySHIUAID6D7YiEFN3UmcGaB/NWyE+5TG7WyF9lY0DA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3566.namprd04.prod.outlook.com (10.167.129.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 6 Feb 2020 13:51:07 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.036; Thu, 6 Feb 2020
 13:51:07 +0000
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
Subject: Re: [PATCH 05/20] btrfs: factor out set_parameters()
Thread-Topic: [PATCH 05/20] btrfs: factor out set_parameters()
Thread-Index: AQHV3NpoxAVEw0RnH0ifEaKl2JWYyA==
Date:   Thu, 6 Feb 2020 13:51:07 +0000
Message-ID: <SN4PR0401MB35985BF74918DE0D8916A5D89B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-6-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d573577-aa84-44d3-a6ba-08d7ab0b9d9e
x-ms-traffictypediagnostic: SN4PR0401MB3566:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3566208082C3027E500EAD8F9B1D0@SN4PR0401MB3566.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(189003)(199004)(19618925003)(7696005)(71200400001)(2906002)(9686003)(478600001)(55016002)(558084003)(4326008)(186003)(26005)(4270600006)(81156014)(6506007)(8936002)(8676002)(86362001)(110136005)(64756008)(316002)(54906003)(66556008)(76116006)(81166006)(66946007)(91956017)(66476007)(66446008)(52536014)(5660300002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3566;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QIPMVft6Xza//oZMszsU+FE9bhPflpkA5/js0jDYmW3+i05PkCWNtTOtqgDkJl4EtjtNxqgn2QyVoLxujRlwTXZORoUXSe97s1ds49p672pxE+88EiWT1wShPRf+/8R6+jWtgwyLhhZcWLUWnX8jcV+Z/ShbQPkoDLgzJ2coJcGhFc5MeDm6B1KLy0nwwz86tHrQo8OlyHJNJZp29ScSTpcJtOdTIbw8yq5WB4rKhQeHKz4Q3ZVkWQY7oNI1lgYsLNCAasPzgQIafxVr/m9JZCUbYN/idGzP/0SMX2Hd6lO6atczW6ikLwxchN25lv2KqPh5AVl2M7lAsRRS7DQUxCa8B1sVv0VSt2IL6sjJEmnrELujtD5MmKfUYTr/ZAJuyIGcqdqWQixyJs981PZZAGcTRvwVEaS/MtrCvzJym2VxsW/TN+rQR8LbLyC+gEDY
x-ms-exchange-antispam-messagedata: FXuTp+3mkVynW7YYW6gupGULArsrC1pw6g9Xx9B51uclU/EaOc7i9w6Qy7tlW9bmmzg6HMqVj5k2udmbZWWHm9RmzLsnP1K1oyE0H8cNJSqsFQTCsJ65bhoboOVTYm42AI8mi8NJrBz2gSWlZTOn3w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d573577-aa84-44d3-a6ba-08d7ab0b9d9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 13:51:07.2545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OcWjRL6VVWFP75ag5vF1jY9J/63e1B5IDR4zB19QoGZa26Tca+jFW0zumYInaZZsrCudQcT1iVa2GpbBgzG+F18lVvFvLJ+/k+jOmmW5isA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3566
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
