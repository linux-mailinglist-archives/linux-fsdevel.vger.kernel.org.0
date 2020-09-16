Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E715926CA3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 21:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgIPTvx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 15:51:53 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11979 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgIPTuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600285851; x=1631821851;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Z3zUbG76ybJ0/tPaH1aZzXUsawgtv2s6z2iLlYPc3h8=;
  b=HIPyyWUelGFvw1ee0AkA4OfQrIRykqdbN+yzaTQBMl+KlTe8l8wdLRWO
   mGuuMTFMvDJIe9XE3NW62g6IihuOU5Vvgdcw+vD9FcTqSp89mC60h+Lp9
   NPhET6i6E4EWHG2XBvN0pYCELn0+uKAMnoWcsZC73/kAnDTr8AnqPnaAf
   alI8aS0CEexClzjQk/qcNXaYU4xQ2l06SSeh0u4+MQQN3wc5ACd+NTPqt
   IEi0ekOZq8b/9GyloOZE6KX2C+SQSsmQuSLYtF/Nx5ys7YzG4vNVpCdXQ
   j7ZR4Agng6TSEaK3gZNnufmi9cU3il3cYEsClj1Hqp+GXsYok3NE4G8nN
   w==;
IronPort-SDR: QgUoqZzDQNDYc92ImH8l6NgeKaIXpZwce38JHLTzaKWC2rH5HpxMcZG1LFm3r2mqUwpt0FsKOX
 Tv2+UCg+6BTjZyX/dflptt1khaJBNt23qy82nFdKGoRuiOQvJrYKPwRPRW1Vto7evvzmwCafGI
 G32b7CZPH9GBxYGnlrjp4d5VtSrPvCV3okwVzTUJdxbnxkrf6r5xCNQ0eqDo2JFxnSxQeGIHqg
 CXJVn6FZ0QtvL7CZuyrfuYJW9c3tQ2MLL3TpC2Z5j9+UI0NrbKKmcXkp0+WpQ3PBPYo8Dc1gv4
 Uyw=
X-IronPort-AV: E=Sophos;i="5.76,434,1592841600"; 
   d="scan'208";a="257208993"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2020 03:50:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij6pH0BgGgc9+x0XnRb3yOkosrhCAAYBFKQkiqOMkHFmj/GbEcXgZG6WpLOUxcvmv/aejyzRdPOKVZsfOk083cFZEUYln2WRTFcbJJ7a5fdEyhDL4w726eJ6O0n/UYZ3wbS2hnwQNy0MJCnLRbpKjStqWZSdSnVG063YixbL4HwZFzdV7Npl2meGjHX/jyf2eGJHuehctMwIR57XwdQJE1R/0utwhvAEXsfPM5BeR9TEWff0xhxceNJ4fitnONS16oTb/MKtABmSOLPCrD321T12QyOqS+Aqeg/b4HF5EO7tbvKuOoH/I1gh/6vzItmf6nH2LHrfEc+Be513hfXgNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3zUbG76ybJ0/tPaH1aZzXUsawgtv2s6z2iLlYPc3h8=;
 b=l3/AihcuuGu/78KUZaXpqM/UbMFDHCp3cghji7WLKihyCyD+5F9Go2ZgU8GTKEJk8oa7qFm41nN81Jt15r+L/Fo0f0a4P4axFFsXj8ceBvrk6eCxLvs/dy/dquHwxjSAyXf4lSmGQTvR7ryqTYSrHcJIQaBXa6P7FbGHG9VbA19h+UY3sScBGY+v7Rs8GmnkiwapIOVfpogBKDzCr0jbMSlOgOzhuJZvxw/tnYnFw2bpcW14k7CdFsDFI/AWi93E5gEg+duwgulBfhO4ArmaBiptDK2taEcDn9+UHTlLDPZLFTAPr+8Aqi871EcnzvzUaWpSTabP3zCExCvN3kTj7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3zUbG76ybJ0/tPaH1aZzXUsawgtv2s6z2iLlYPc3h8=;
 b=e4DA3PLWDUe4uGzHT8AkTpkUP3A8diUfi3vVNJs9OBwpi95eRAH5ZOlCf8WCK5DS2b7E7CJg5LXggl4iImVFkOnPoofuJ/wFX4E+UqMARhW6pm8ehVEd3yU/9yY3sOdMX66TeHA/mQBuumIKgGfvcpAYhjVXcTXEwr4a1rDbnR0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4685.namprd04.prod.outlook.com
 (2603:10b6:805:b1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.19; Wed, 16 Sep
 2020 19:50:35 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 19:50:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v7 00/39] btrfs: zoned block device support
Thread-Topic: [PATCH v7 00/39] btrfs: zoned block device support
Thread-Index: AQHWiGNae5boCJrRrkuIphWp+J5npw==
Date:   Wed, 16 Sep 2020 19:50:34 +0000
Message-ID: <SN4PR0401MB35986C56ACD3AF5B022C3BAA9B210@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
 <20200915080927.GF1791@twin.jikos.cz>
 <SN4PR0401MB359839054A125BF64641B4E89B210@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200916194657.GQ1791@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1460:3d01:38cf:f1ce:e1ec:d261]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b85e392c-9d90-4abb-8900-08d85a79c712
x-ms-traffictypediagnostic: SN6PR04MB4685:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4685D508C4279D3E71FBB46A9B210@SN6PR04MB4685.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E9XxYFm6XH0UadaRBsUVVvlC8lGNznHkP1hN5JKNGyN1o3uLTYrhgjXkNCaX9r06lnjeUvhh7Io/UFZT2gWkJS/IFBoxcqKcDtDlv1UHUfHUoZ4iowxKBq41tCx6bimnhSFWPwHyPgj7pSwN1sBGF+2eZBaVdbJDW2/sW+He8/1CzaAhoLPJ0q0KT9IF23GI4MjMNAudfSHiqjGNmCNGwEZ2MH0xDECYgb9Cjv6Emav1Z8tv0hapsA4hezHyvcdQWQBW9cpw74106TAI0HGnM3FQSRYbyUyoH1KPmBwBX7xqunO39B/xuKiL/iM7SwUN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(52536014)(76116006)(66476007)(66556008)(66446008)(66946007)(5660300002)(71200400001)(6916009)(7696005)(91956017)(55016002)(4326008)(2906002)(33656002)(316002)(8676002)(64756008)(54906003)(9686003)(86362001)(478600001)(8936002)(4744005)(83380400001)(53546011)(186003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2M/d2hOjJ7S+osCrEL0VFjBblvlVzdBdMydb01/Iw/eX8DVeEsWdk4ecdMGenC7VJK4hEaD1WeRaykeb3a/gj3ir1N1u2N36QTU1Ju8YVcgRvlV+zzKiCNHYBSik/3prtmWASzFF7Bk48xUWEjMV3TzrVm2ZdnW4qw6KDnHS11gfPY975Js8JCUI+Oo85nTvJVRutsf9MZRnHgaO4oVAzS1N0uFvrMODUeGmuLNJGLJeyyjnPRAE/19kEgSAbzN0p+82YOEvqlJb7GeABWYH/zz8i2CCEtT/21fzWehX/1TgDqKcbw0v454/8mA4lgfCnHEHoqTnX1kiXNc3cEDT2+91ys09RNRI4EHVcIBYUHi+x+6oTC6rJ+yXeDTk7U8Lo0RqDcAZaowrZuUxqh3MUdI8V3J69jYsWVqF4EBnrF7Z5r5GwVP34RphWpw6qhL0IP4jUzV+/Spoo4uMvjZ6NTJHl1MnAgxsGWpUkKN31R4BgLhh03S2ClRpSpRehKvn5TKIY6fy3ZTupflIHOkT+OKS6ux3aErk/lTqd5dS9KFii7QmFhQJvf6zzAQMKtDAfVs17Tg8lQb3dA1TBTDqQa7lIuV2/SHg1YxFHXbOCuZU/QO1frg7zXyUlvRp9+Q2+8Bjm4z7Z5b4b8/TPlZzHy6hNclZlYL1FUrtHm0hY4Xp0CDw941o+/JTGUs7DtfcpJvqs/x7icMgR5jiuYm/rA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85e392c-9d90-4abb-8900-08d85a79c712
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 19:50:34.8809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XGaTBUJE7KhMSEU+VAwMnokoTV6sKj91Wqkx3pKvPIACNCqY9YwlRzkD6fvQREVT+kBBzExwR9ZsEtY/QMRbhPbUKA5N6MYu2BXJM0uzgoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4685
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16/09/2020 21:48, David Sterba wrote:=0A=
>> Can you check if this on top of the series fixes the issue? According=0A=
>> to Keith we can't call bio_iovec() from endio() as the iterator is alrea=
dy=0A=
>> advanced (see req_bio_endio()).=0A=
> It booted and is past the point it crashed before.=0A=
> =0A=
=0A=
Thanks a lot for confirming=0A=
