Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4DC1C4FB6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 09:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgEEHzd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 03:55:33 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23688 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgEEHzd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 03:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588665333; x=1620201333;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NCoXsWo0xaRNmTBDowQ/KYn6TemqYnCDDTUcN3If8BM=;
  b=FX4vlDg3C23jRfL53eNhPmp1fruZvk9KvE3HDk4r9zzUZ/tIHPp9NM9M
   irziHeGC4ky71QpYHDfntFGstW1mu5Ogyi60Ug6OYddodKxKk1DGxcdEm
   PEUmQzF6ypc42qm48yRtjA7FL6CjFVabvdUHXNKVeQjriQxitLmXqGuNS
   CZ11RdLodQumrtUrUby/SKxbaLV03gjZzGRu8AweMtAb+XRVxkNu4/Na4
   gouw3OQiu/0GnvaenUC4OpmJqZjJ1LV6sDWmPdaMRoo5/MY8GW6Z5hF+i
   SLS4bx+99xPtWMjhnqHePx+4/quBxW6ajQGqzebUKxbo0uDPHRfGtCML5
   A==;
IronPort-SDR: hbMat6OYwPndiRaK3FvjmAkN9I7e9C8LUPC2wThwhYmlfqEI2jrDcPjRVDHRz1xOV7ih+qMfQI
 K1TqdOOQ/pVp7P58gqc0dGpndnoAdtaxro9UpqK5GsQvIT8yqwwVVtV87kFJ0zSm1QUjSX4c0d
 tmLlys+D0qFui1FSEFLAwYyvgE1aocnlfmiqEzHcxOyQ8Q6pBK+Qd0G/AHB3pM5RfIb4NG84LW
 7Grr9637VyFAA+VfJHDxvqKdXKqU31UxZkOyTU2SddgHfxfRyWohi1+CHd2IymyNAQQHDz7Mb0
 +Cs=
X-IronPort-AV: E=Sophos;i="5.73,354,1583164800"; 
   d="scan'208";a="137270683"
Received: from mail-cys01nam02lp2051.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.51])
  by ob1.hgst.iphmx.com with ESMTP; 05 May 2020 15:55:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6Wz7FhfT4xJ1XXysZjD7U0IWGxbrWMvadIUIMXtR98tjFqwCmpXxhox/psmbmXvPP6o7rzDGgdMUKee2JxnVUIGe5K/4wNUtthmYEHWBd0kXNzncXIfLf2WrDtNPad8flPXWg0EDfgajgD7PyEGls7sIU+rbDfUjMXqd6Po32baUPM0zLAE3+C4CC5cS5o5ShewiTE7hiz2bPdwiWBFcUrF6bkDl5Ohy5LHJT8JwuUIyaRbwR0s3DCXGuzzR0soJXvb5CjhxmhKVpjpOqM00M0PGywiVLwFGsLmx2Dxtq4kRe5irn4m/e2zFhkhi8ibVVaGbZW5aQNlUJyFAtovHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCoXsWo0xaRNmTBDowQ/KYn6TemqYnCDDTUcN3If8BM=;
 b=e3m+zQFs0TTHDnU9sgZ4OiEq56+rM/gHbSru2zwSrHAnm+9TS7MoT8hTnSa8CJAhdzO78yF5/S2CLibv/QlLjNduu7yik3bRQdOs9icwkvCx7UQVIqI4bYSSNomR70zuPv7/oM41YdlABu04KIJ7dI5PdEShunABQV03fYRYZnQ2WJIUA6Z+gschsubvuFYUa08mw0YdOJGnGf4oxHjjkgyqQbL+aHcIX9P51uq6Mm0H6lAAcfeIXNOl4DfNrVJ8WoOKioQqhaWMhR1DbMmq5cHQzlQq4Y5c6AMy7QwoYHQUurf51WyL92uR/OjzdY/tAJ9csiAL/ZXmVqm/EhzBoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCoXsWo0xaRNmTBDowQ/KYn6TemqYnCDDTUcN3If8BM=;
 b=QE8uLjhsicUMns1Wp0BxiiMA4TyF9zegd0PJDEnxYiKQoS+K+qFddOqJXo5zw/crw9LZIaGBEv/IDvP+MOGC4U6YZV7G26qvpIJ5pTj1vjDwAsdmaWyVqF5Jlvj/gk/VuZeqz/lFILyc3M5JMiMbVEx0NFmv2c/aK040WT25jxI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3664.namprd04.prod.outlook.com
 (2603:10b6:803:4b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Tue, 5 May
 2020 07:55:27 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2958.029; Tue, 5 May 2020
 07:55:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <jth@kernel.org>
CC:     David Sterba <dsterba@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        david <david@sigma-star.at>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
Thread-Topic: [PATCH v2 1/2] btrfs: add authentication support
Thread-Index: AQHWHUw3Fjk34p8J2kWvUrIfOj4HzQ==
Date:   Tue, 5 May 2020 07:55:27 +0000
Message-ID: <SN4PR0401MB3598DDEF9BF9BACA71A1041D9BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <164471725.184338.1588629556400.JavaMail.zimbra@nod.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nod.at; dkim=none (message not signed)
 header.d=none;nod.at; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1aca30d9-535c-49c7-279f-08d7f0c9acee
x-ms-traffictypediagnostic: SN4PR0401MB3664:
x-microsoft-antispam-prvs: <SN4PR0401MB36643720C5C9FEB8091E3E0A9BA70@SN4PR0401MB3664.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0394259C80
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uB173FEChH/bE00F5ThCiMrdC/gDN4eJtjQGSdiLl3ikSJlopAE6xKZrHEKTgxgfj4bljRi4+5kfgWwD1RDDikalblVbKIDwbmoEBazPrlbTnatRMAFmY+Wc14SbeXoAdB8s3+2gpCWgxpyuYMYAuUOAvKbysBEney6h2Fjh5f3um7Rbm9Zhu2FR3ui6t1OA/yJcpE/BgWmwUNSgCX82i+pmAe2AkE3lMFASZNt7zXIzdFbuNVHg+tOAjrSgJyK+WEU0FqiNuHNFXCznNKRG+CBBSKHMBwPQPc40IjOYZX/WcKN5wKgjgiRzwG8r12QKKt/kqGs5eYmUIg80wyR1dpOmfyyXZvw8rPYImPksS3Wrc08YzL3VsplgoOl4drCPiQKNbCTtGoyAdVk9Q/EYqopNvIc6zBpIfnGpN7BjhFW4gTJgUtAT0pEduVSytnaho4MDc6CFpV1Z7WN4Oy87Y/XGpIglzmgThN10chvGnGhcDERHOsGFh34frBYxMxxa7Ojxck/3n+fUSJ0yevenDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(33430700001)(7416002)(478600001)(2906002)(33440700001)(316002)(110136005)(33656002)(54906003)(66946007)(91956017)(76116006)(7696005)(64756008)(66446008)(9686003)(66556008)(66476007)(53546011)(52536014)(4326008)(6506007)(26005)(186003)(4744005)(8676002)(55016002)(8936002)(5660300002)(86362001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OV8j9hbfi9iguuz2uzz0oFwb7HQcCKyMMXEtuz/xmBJiaGMwolCjcJCeHmsSYR+IWgUptdA+T2bY2D8H4y4U979U08L6Q+twubEroHDSiYsPLR+RiB6G5IH+YZLfCtaEkjpSx9drvA/XlZjZp+n4xw15wit0l9djMUq4s26w4IZOfc7mVeuOUKAD9nfnWycYG06xpCrPYElABUVIv1J2Z1Z8wkAPqgymvoC47Lt4dYaankVU5v57XhG7D8cvOj2yNGChTXamwfKqIKbIkzPHRKeUUgFA/nBFUulDcjA70aEq/y5SllsNWJWnQUXuzuEhzDuBBYKVo384MRjBoTKvPxcPstJ6/EI0FFsXH5Tt8BwpohvLG6y0+JBi1He/zRWLEQT47Xh0Cvc9yIOZO+54ml+QIjyrC5GC7URfK02q1nx80jN9mvUL/h80EWGPq9lmY+7JZxlZo59YAbEVMlXuoiuOePyKBkviF6hFhRhnEyji+/yaZezK0LJ1KygwDV1pd884uGYqM4tGd+mtQCxvJvMzbDmpmFx8kMUG2JAM5z1SgUKIY3K+L4Nr8wteA6CfcuXIWYHT2abGEhBqDoW3PDuA2vIqZLQy5R9zl8LbU8H4aLWmCjVwmwz0OqbeJKKn9yR01a1y+ddisSrI2FekBmitEBL+JoAdENhpStmdk9kYm/C5Dsw2n/xLG6FVlIqNCw8GAc+BMURNeMx1cOoxwnaHiSLNb9MfitvLZExqR0N0cxN1YhQ4mu0s37sR5tmFuLtqY4mKYPeevZuvnQ7/PAm/1TAdEDGkf75VIpPfdF4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aca30d9-535c-49c7-279f-08d7f0c9acee
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 07:55:27.4657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2bF35RdUSKWjm/z82YBzlSxXajg6r+cZRrjpbYRNMPr7DvnZJZajSHsvMfiQYpwx08q5IM1wsHFGyR27k4JECSpKHqGanJJyDVJjBMhIoRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3664
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 04/05/2020 23:59, Richard Weinberger wrote:=0A=
> Eric already raised doubts, let me ask more directly.=0A=
> Does the checksum tree really cover all moving parts of BTRFS?=0A=
> =0A=
> I'm a little surprised how small your patch is.=0A=
> Getting all this done for UBIFS was not easy and given that UBIFS is trul=
y=0A=
> copy-on-write it was still less work than it would be for other filesyste=
ms.=0A=
> =0A=
> If I understand the checksum tree correctly, the main purpose is protecti=
ng=0A=
> you from flipping bits.=0A=
> An attacker will perform much more sophisticated attacks.=0A=
=0A=
[ Adding Jeff with whom I did the design work ]=0A=
=0A=
The checksum tree only covers the file-system payload. But combined with =
=0A=
the checksum field, which is the start of every on-disk structure, we =0A=
have all parts of the filesystem checksummed.=0A=
