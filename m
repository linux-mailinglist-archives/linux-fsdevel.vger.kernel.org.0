Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C023361A11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 08:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbhDPGwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 02:52:13 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:57250 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235140AbhDPGwM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618555908; x=1650091908;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=qwRVCfNM0z34lB9qO2kcZBTx1m/glrlyfJrGBCiVls2eKmwHhxkxRG5L
   yE2omUB8H3HTzGIWmMM1/x50GHh0tjNsryxrqfWg50fPIViBiY/7/qA4G
   l/Ma4V4fPV9ouXIGAooKFJSvy2pAr9Xe2Hr+yI1ADQyUhbWW3YkLTcWrv
   IXwdr3pmT3NnmmO2WpNXDIy6ydkAhE8ANh49CvYgyI9L9hBggRonVZPdU
   UILxLK04l8H0cArTwYv8l1oOR/Ji5Inp99X/OPhZmORxgaknUd2ob8Pos
   j+ToXlv7XCZDkSomjubUqKJjQcijCQsrF0+ul7+T2hT9N7BwM4K/IZ9ij
   w==;
IronPort-SDR: bgWh6DPrNkqBT3Iyaj/kYXgihbOd8qpHH8eDilIcLRl9l5yJalaP7Uu/Mkki7fWgjYvMz2qDH/
 ZSzun7FPWrc9cqZ+plxWL2P9E89DR65K6tr4n1XZpQRbKHG5tNLuTCwk+RBE5qSt6kRy9DAwai
 mTKw+Hi1Ni+/gebdf6kZjZgjTTqfpcodYPZrL3pRANeSkkBgFa40Kpv+3xqgwC/EpzOHl4/jUi
 bSb2r4ZjnwB/z/EtOvr0ZtoOuEkhAm4zPotHR/mPTX3irlG3YXEAFWuSREXC3x0Q5M1jP9psdr
 gCQ=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; 
   d="scan'208";a="275974625"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 14:51:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWu7HyRu4STi5iXdIJe2hN29SGxt4jw5iDKNBc2nA1b+yHdyBLiK95VITBl+RkCheZ8KBH/Q81fvUTc62S9JT930S6h7fi5TxROt+FXFWBqMVoOZ1YR2Ti74AYH55JYDgKH/Il+XvJDpqwBJUiVMG24deFjDbaB9TUnIhSyupEPhQgzi+bQyBHA4vDE5gb5VyJ5g6im+1eAeVV1h6fYP+X1gB2rEuV0WDeB0HIpulr14CbAhr6TQxpBPXluIBuIky1q3QfA+YfueU5SiGrZHMie79e39OFXL+UGON35EO1DUi5tMUKaizoiCs2U0mAmzUgtR+BGFlxsujchLD5LcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=nMCXx+mMXKjQwUv2XKu+Yxe/vZA1K6OCZOwx52on7+VC+DUo243v5Uf4eZDjuf/6JsOFPc70g2VJIvH3a+5lHbb8U0Z9s4in3x7Yh60a3CjpL+OTsGUYwjMEmSyu/5C1eUDf+1qrU1SUZk4n+YtD6Nk8NuSH+MJyBhLdaLalizlIxURQOKbeG2/HyjBvX2+ynpI7doZ+ZfDb5lP6BL2vOoMHIq1Mxjm3bPD4mb/Lr8eXYrzYf4UXdyX0G1eGd6MJ+q1Zw+EzIrXBXExovFHSPdsdphYw7Pau9jGznpno8eq9RFtP2WpEvmDY78PvM8LsOKdFQYlIzHVyQmDZK1eRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=LqGbMPBATNYZ4RqFW6D96lVtaiwyheDViT+hWw2l21tn0ZtB8LC37UD2MrlchfeUXKx1QenneiWH7KL7EckoS2ttAXZE8gq+sa4bpBGk7vj1UmPaAPvMwsO9sK/8ZuzIj/ziA+bVvADqFTDRfxJKYcZvA/5k5/xuL21T1FJS1Gw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7334.namprd04.prod.outlook.com (2603:10b6:510:b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 16 Apr
 2021 06:51:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 06:51:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
CC:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH 1/4] dm: Introduce zone append support control
Thread-Topic: [PATCH 1/4] dm: Introduce zone append support control
Thread-Index: AQHXMm1gL8WU7E5fp06Z3hjUVfsrGg==
Date:   Fri, 16 Apr 2021 06:51:45 +0000
Message-ID: <PH0PR04MB741615DD316F6B22E1A4D8929B4C9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
 <20210416030528.757513-2-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15ab:1:e10b:72a5:d443:5e5c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56402fca-d0ac-4eec-8aaf-08d900a4198b
x-ms-traffictypediagnostic: PH0PR04MB7334:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7334515AAC714D814DB51B3D9B4C9@PH0PR04MB7334.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nWXKf3vsSAWGMZ0YfJZg3U3AW87jFpLJunl7aiUVltj9piGfyTvGlQT0ZNeozBG74OnrqeIWlZQ4qV5gyUZHyTkWST4nMB/c5DvKX4Odifi9TnGBvGmICGjb7+jXW7uQS9IOUs/VQddNr6SlVxlQcyF9qjzGtzP7jzjV1RK0/eoix+0dZe7NIZwm5iNkTZdwEYxFhucwA/JmxLK+DOXUHTj25JvRG5jUHnhuqKQHE7esshm/aRUOiEbAakFzKm6jVv1XZ5k3I6IMKqLYSKIWPrpMlkC0vQjEmZTJxuPVtpldjxC4guVihtcuvJ5ZDm+z/y3nLcBpsMmU0jBub36gyUAop0LJvX/JQRSSjI52zPZ8vMDsqqjvSiRgy+epkvrzXt2DOz4hcttthaPtCKEPYF+7IlPPqhnqm1fS2fC2dskNC9Zuby0s/lUcWJQv2+ajQ2aJvysZJ5aEHCpRstwBk8q5UV1OC5PNTrOMbaDbjpPlOvLdpewmnyBxpurSAhb69hsp5hsKWKf9KFdvGqK3YFcPSnO3fiF6lOyq2DwDNscTaVnQeHKLUrHF8S/2y38KSdtgoX60wda+oCXKgiaO2yDFkoaTxdQ5AZfexY8rITLq8yOF4Kh7O4KpUSAqDW4ojl9YHEeVKw9KGmXBW2gtuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(316002)(66476007)(66946007)(558084003)(122000001)(19618925003)(76116006)(91956017)(66446008)(8936002)(64756008)(8676002)(921005)(6506007)(110136005)(9686003)(2906002)(71200400001)(4326008)(7696005)(54906003)(86362001)(66556008)(52536014)(478600001)(7416002)(55016002)(4270600006)(186003)(38100700002)(5660300002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pMyEPy4tuVErH5BMrTvk00eAsVBaBA4QX9cJ5F5IJOdyR7qY/em2NeI0cn/O?=
 =?us-ascii?Q?i/zbkajtYoITGM9gzrSHCKnjT5Z40bHATGGhUJ19YxXU10fAtZ7rTT1oVE5s?=
 =?us-ascii?Q?DUclRtGY5kRqfzGQTdBm/0ei5b/vQTdL4ucGV5Jc68uC59BygtdQpBrbVldJ?=
 =?us-ascii?Q?pMPsAzJ0Pl+vS0oYii+f92ASdzcqv1RJMKbwqBRXP68IAwo3T68Cil61uZ0e?=
 =?us-ascii?Q?i8Tiqe1BZcpYJhf740MugGUxRGDRSSZC/ZcuENqM6PdeZbZTc2LW5cul+xOJ?=
 =?us-ascii?Q?Zx+iSxKMDBln+zY7wgDJGZ//4Pqo8A5nKP76Lq+861u3LhIFUZbkRCZd+s9p?=
 =?us-ascii?Q?XAUnlrz5T9VPsNZwkp26wyIIylNp9b+GkkZcSzA1rnZ09S9NVea8nzIjcX49?=
 =?us-ascii?Q?fAHhQ/daMlOYFBSfxjCdQYAbwUIhVopMszLa81y6075/LPCaw+z35Jc5fKCC?=
 =?us-ascii?Q?8oIOLaJr4W/o5zn1HUZutah+6gcmerlK8Et9M+tIKtoCXpG1+2b2SVzZTnZZ?=
 =?us-ascii?Q?WtdB1vE8uk5K6wMDrGH7SdkRBg+js0OtC/CwxLaaumfp2dtAjUmiZgQnES62?=
 =?us-ascii?Q?XsKk/Ta/lZzqIwm+h7AsDXE204Hmq9gW/KPeblojVp/DgHV112tYoGoCEf3s?=
 =?us-ascii?Q?jFhHc7A2yEOpIb1+b7Z817lOSoe31aXmU0YEcNyDbf7LOLU9cX/gypjjxmO2?=
 =?us-ascii?Q?/GsF/ucdIiByWUUm8E3YNxymrU0ol0cixF7okVEefuPYZwWmZFOMaGp0+lkO?=
 =?us-ascii?Q?owgH4bwZmLOjvF9dap8W4hxY/CmKQ1cr8HCWSsZbYEeA65+8UMhSr4xVnROj?=
 =?us-ascii?Q?bV1fqh/IKvFW0iQRqzop2bO1ECAXFWAAzGAng/v9pUvRWdGxD51QS0Oh1qbd?=
 =?us-ascii?Q?4YYhpQHTGL6T7n5jmw0kux8wJvUvSPF5UiPSRUunc+/zUsRy6PHLOxYeUub3?=
 =?us-ascii?Q?2yXt9xxuWyJzhB6bkOOsCs7F2hSi9JoAkWnfIL6/7ELse3CBK3QsA8qnBHH+?=
 =?us-ascii?Q?MISjHSTWe96GpcbyKhqZlkEG0RvFr6CbSaCYuVBLw0XmSZyt1Uw8NzTsLzkj?=
 =?us-ascii?Q?/5HUak4dRFM64TpRUeMUDDBKHXHlKi/kFENSG4LFHcoFH/F50ZVZIIWJjyKL?=
 =?us-ascii?Q?H+xWOMnxWda9QRh5+rDasP7hH1ZJNHWsio4DFio69QIpwHYZ+Ls8CjMTUjiw?=
 =?us-ascii?Q?Rrk/Q5ZITGhcfHx18wNMTyUou3xdjmeKIhIlTWt3XwNogc7aVEsHVbVpJg5h?=
 =?us-ascii?Q?pAPrJPys173465W5m2TIKn06/LhULh5ibMhRKFAVPwQqmwXhF1wGVmYrQnkm?=
 =?us-ascii?Q?h6d2hhU4GJN9L8aPLk+RUYF9qh39qHTfupMp5bQgbH7O5zhbwKcednDEm5bs?=
 =?us-ascii?Q?p17umDkpJNdV+1N+bz0ETdrg1I83?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56402fca-d0ac-4eec-8aaf-08d900a4198b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 06:51:45.0776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yvmZnU6qTLkVYUsaKzL4kF8NkKKABmGOBtPKyt8Cz8HoIyelKYXWQf0JgzwrGr4/vIyWeqGN48tXo2LYUY8EyjjFSaeT5bhk6e3JGEYKPK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7334
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
