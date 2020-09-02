Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32D025A62B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 09:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIBHMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 03:12:33 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24951 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgIBHMb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599030752; x=1630566752;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0NbgjcNZ6BEopNVCjXPGNvYgHH4CL8Pic0vs/68qwO4=;
  b=NrooGUu3FTxY5MNKOKbKXZ/oveLkB/0ke3swkGl4wIYoy1EQqrjhgAsw
   BdS+qFPjVkfln4rxUYViXaygIsvOPfjw97F3f3ycIIPPyRyVMkxlBZO4X
   1WFM2FrWzS7LUPvNSxtmdc1IJUVkbXd0jv+bE07l6D9pPHbZlhts6KKuX
   K4VZWzYW99zMT42PEVnRUj/YTmoPRVDgXutl4c2dedmVuhZ258meTt5OG
   29fjbJk3Sgm9dh70qHYSDv4ICXsAiWR89SmpOXleSK4pAiA+aWHK0atO6
   1HcVGQyR6MDkIrAbtZkFBNW8sbz7iYS2Mj2UEym1mhJHLdoca7muMfuMw
   g==;
IronPort-SDR: h0OHh8XW0tMsezI9DFAhW7zRMgq5KEx4frOwVhaP8mw/UJglScdYUSME+wuENLEZ8ncQGDvKzU
 4ZynhWtakSvZRg8ODHWI+oU409VdtDrrY4sneyk9/JJTPq1qFflASAzT0Ir3/l0cCXinqHtJzJ
 xPe2BYkx3qk/tPiikBkTTcdDlI8XaOmBqmQERCUg0lCF7SO7w4BOrHAPCEFXLhpOg3HjQFoQ+p
 k8bGRmqinI/CC1TnDSn0GUSFKE1VVvtUfZeE42Ci0AFGuRTgL2gBVd6E3p1FrIVjatJ0yjFoW/
 Gek=
X-IronPort-AV: E=Sophos;i="5.76,381,1592841600"; 
   d="scan'208";a="146377042"
Received: from mail-bn3nam04lp2050.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.50])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 15:12:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWGNzgUZ6m7HxvfGOAwqKE4zgmJXl+Bb+pn+mqqp7L0eLV+mfQzr66EKPr9rrquaeKrDBcXmbdm5sPBZSlSoKq4jIsLXL9ah63A25MIT5h6ES1XjuvxiDCshWlk8SpOy0niVAFxvwI03ExVY8is8cGZXyMyc1sZ8DxjL3b70cnlqofgD7VQ5oJfixKTU8b2Q3znUFOL0hLm46vqKjoCUxTrCbK1UDu8iAWVQFcK5WNEL/r/SztaVDYLaPt8ZzuYToO4zY69jJwWCNqvEcB192IE2hoygNQOcipEr0vAVJkgOwV82B5RBBp1CYE6KItwWAyGTVSwum0SPkwTH4O4aoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT+r45Tjmt696dYt/b33qzBaqbC/Gz5e687qL+VoEVw=;
 b=iGW6la0lVFwJzSF6cEphxvEOMqDFjNqLZKIUUBAPRCXIh3vJ6xpk55CWFRX0Wu/AFTaSyi9GU8l5nVxwDgmvnn7EX2RecAO3cha5uW+gg5YbvStQYzNNwM7B66j209Shwa7iZdQOW/zFixjucDAbQCnYbW1R6QOfx2AOl9Dg2Kh+IgAeMMKebV305nR/icEru3DRFwSGIrxz1UQVqDyahU9DJFLcRPjdCdznSEZrLAygxit6SK23oIRyIHVURc9h6ghbkBkfc/ZDQDoFFf+rpFxgTdzcntxUZX3P+MhSNouurKoodMP/3RhqlVJM2PGJDhoCZ2fN9kc4geXq22BE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZT+r45Tjmt696dYt/b33qzBaqbC/Gz5e687qL+VoEVw=;
 b=lZ8En+OiDgBIq9qQGHVSzM5Zfw80VgRgPrGavDA2mG/RjUKTCioJqzqZFU4x1LywU68A49VcW4QDnEFQNjJjO5uV8ezaH+tTa0P0DdlUhcyzaGDtb7t0cAlPNyQMjqpRZw50esW8maJbymi/st1D0dvc8NMnscRcTDj0bwM21hI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5245.namprd04.prod.outlook.com
 (2603:10b6:805:103::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 07:12:29 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 07:12:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        Dave Chinner <david@fromorbit.com>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
Thread-Topic: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
Thread-Index: AQHWgGDIsm2Q9fFDf0qcho+qy+MPJQ==
Date:   Wed, 2 Sep 2020 07:12:28 +0000
Message-ID: <SN4PR0401MB3598CDEB0ADC4E43179DE2E29B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
 <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com>
 <20200901214613.GH12096@dread.disaster.area>
 <551b2801-d626-9bd7-7cb2-9d20674c06bf@toxicpanda.com>
 <20200901235830.GI12096@dread.disaster.area>
 <d2ba3cc5-5648-2e4b-6ae4-2515b1365ce2@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:bd07:d1f9:7e6b:2014]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e897deb5-4d70-465f-6bdf-08d84f0f8d7e
x-ms-traffictypediagnostic: SN6PR04MB5245:
x-microsoft-antispam-prvs: <SN6PR04MB524522623B977A562083296B9B2F0@SN6PR04MB5245.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N7SQAT3xRJpXJLdKpvBwFAP6/SBWR68bmrllvFoP4ncnnDezsdBj82jIy/VbaM49NhWkmYeHJiiRpe0XY8oueppmWmngd5H2flGHut3ydL16W2t9VjSkoKBktkJdYy8immcDxpEAIvlfFRs30yGnd7Rzb0w+Aw5F7wwtkglOEMB9czUhYzIGlIbH/fNbWeZa5pafj9ypcI3tXmNElmC6JWIAZ8ipNMvo2mIn95z8+Ieuovfkb2gJ/lbnj/LQcz50GhsgIVx+dVv9YoZ6lq0CvPpTzhsHGYlUkRpbNpUc4r8/cUzCrWwCHujWB04pf7kTsM85cyymB2jWMQunlZtXmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(7696005)(8676002)(4326008)(8936002)(91956017)(6506007)(52536014)(478600001)(66446008)(55016002)(66556008)(5660300002)(66476007)(53546011)(76116006)(64756008)(66946007)(4744005)(33656002)(2906002)(71200400001)(86362001)(316002)(54906003)(110136005)(9686003)(83380400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /z3j1Y/OXHVNMjv1nxKkhoVQ/An7njebm3S3Idp/zC6KliOwJnRkX2F+oGot7OWEWlmNVDnMZQB0/TV04DmzgrOVWJqYDrkI74ai5Ln0eQwvXsho6JyE5fEXWKMycj2VZX4WS+EqzbAXp1aYGCrVCTqkDmfdc/VcOsiYgFzQY3qeEwU5My9Xe4fs4KklFPz1yz7oTBAZ17xPH40/q0MXCb7Mz8sCmx7WHGuIq+mEaPs2ulNH4egT+bl7HglatFHaVM6ce0UdRVKLROiSG3cu90MOPCmZFZPjyvU/DcIp3ookpgRT4aawNjcL7MKQzie8azpbBQaXr5ATR/JhreWfI2qAyB5Vw9+ipV3+6bdumw7C+nwGfmMNcTD217o/ZWC3fZSOsSsRgE23HVF7M3XqCHbvQ3FPQkn13u/mUz4VXEB20dI3HT4aqrpI8QK0QsZ1t692/CaPe+/TvmQbkV8W9Ihmu1ESmpWwQiKdVuA8bm6DzvIKZIQLuqK1wirT8tG3VoLdJT0HL3IoJyGiOmF/kjfiBxm6oJ7jnpkBXwrf1tZKevAPwrG3QfV4CDM3ZrJ+7sVwfJRjC8/t7k4Ro9UgkdGgsiT3WzHzE839aX7vYcmkPjNAxU8/smG06dK0XEofDcgboLrFwvZT7AILqmRZ796oSdczAXyevOfXHnJA2tIdw9uZtVRyK3x/eYSemrVrzt0PoB2rjc7ap+PLqfvI+A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e897deb5-4d70-465f-6bdf-08d84f0f8d7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 07:12:28.8462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QK3JsRvJYO6aEulK11KHdJc1WrTEldJIdB7XDJ9E/TDmW260pm2lNUpw++/NLwLYl1KJUVq/Hrp6DWr75+xFrp1JFNZ6lUnf451Vc0zRjYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5245
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02/09/2020 02:22, Josef Bacik wrote:=0A=
> Instead now we have to rip =0A=
> it out until we figure out what to do about it.=0A=
=0A=
I don't think we need to rip out the iomap conversion. We can =0A=
take my fix albeit not pretty, until we have reworked the locking=0A=
around ->fsync(). Probably with a big fat comment attached to it.=0A=
=0A=
Byte,=0A=
	Johannes=0A=
