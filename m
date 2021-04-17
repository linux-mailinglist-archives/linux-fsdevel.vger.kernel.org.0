Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B536A362F4C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 12:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbhDQKkJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Apr 2021 06:40:09 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40583 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhDQKkI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Apr 2021 06:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618655982; x=1650191982;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ai/yzBt7Ky7NLTRJVYTLnD2qompLA3/cHvrF82laNEslpYF9d9AZHZnZ
   R9EW0hvBPCp4hmtw5NMELEzRtPNTl2nZLvrIv+2SRox+FUPe0/SddQg4j
   g+oAt4q+jGB65OA8hkT467vnxPfkJ0GfbVKd/Dm1jtq8SnY7WMiABbxeA
   hvESxlkmyLL37QVubL2kGgIshppUXKMePORfaL4QuMhL90l9nPPBDSXGi
   LfEJdbb5I1iM9jlUBTIWpONzWb/Z/aamzys3eJhvKSWH7zbbjSfg9zF2y
   admn9N54TPVHct0CW1GluLgtxq2tX2/aSXkICuuGQF5IOKn9qvP4gN8y6
   w==;
IronPort-SDR: wfWiJcAUiI5ekMHeGwTMIGtZE4gAELrZqcXrFvHrkgwrd4L8pigGdWpIaJxb3x3XlPewXJqBFA
 Fg5cPNDkXNl4v2o5fTT5297XO2LePf4+Tt49Y1ojY/NOxWwuuLy8kAKFxmOVpok0I26zCGus4j
 j5HnDtFIwH4A0nWPUtuBqqITfwZ5NHft/oTCs/UCQkbHsyKKoyMkbj6TCS9iCLhejrfOUvHwtw
 GQcCUDgCYk4O1qoc8J9bo8r5Z/5nbQapaCMhvSV5A4T5CVmLb3pEN8asd27JOm2wmq3M14QG4H
 eEo=
X-IronPort-AV: E=Sophos;i="5.82,229,1613404800"; 
   d="scan'208";a="165238389"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2021 18:39:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WB6yELMSAjoIi9mNuhvBBJVxUOpp3X2ibvqdGxizj/uJ7siU4IN0Ho9NA030/CmwyweDoPCH1uMvKqmwoAYw8SogEdbOCN7/FAMVF4cNl1CleRVz5MQnsamdpBGHB/zB3R3RNBBunVbfNLs7EUbFFoaZeWH2WuknFJ02H7oS11EOqcB4Yb9Q9f9VXbRMb1brVJjTADrLno/EmZc4xoSlRut76hL+Kos+8bOOjo3k/AYJRmLutAC/LYbn6vJoaul3TIf/aUNFluWu77wc1/9zgNtHsuKAwVN3Qpx7QmEWFo3vBT+MGC7xuFPKdOY7wFXJ1jlMmN4CuzFaDKiU2pcdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=SroFVueQxeb4m206krQMdu2lBQLXHMI7fFbgRLpeyTphfmVB6FhaqOL+oECYMbE6rok79bYDQvwGgSDmTY++yGNOaPKSRHb8UApMPwMtNL8nhHB+rylIVIeDnBJaicAO2wCo0pXAyQy3AwFmPVeH29GJOJQXJU5lvyOH5ONXYrzEZrnzhFIO4CwNvSvSf8gM1Dzs9pYruVz2ucyCMrChZsSfWAiw8LTWQzJq40XPVfoKeqAFSvXjkcfH87ApPvTNGNbQmtDf8yGNinXJ3ew+bBYq+3N1ncmz3NcV+eXPIKMMrOCEU3tQCWe9ZAJXa7VivcH8IfQYEM1jmw5SrUaZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=zKTHq6OB7tgrKXYpHvu9Q7/xPZGZSlYUDQfUtmeNJ9Gp9sGUB4/aZZ8A3qwXGSJ7b5qnRaE32FdjiNxfKEbuNsz3f8uA5TgHImBaEs3xvzSPpHj+6wh+7qMc3QKOpjSttLLKNx+/TQcyIAtL13UmBmP5DOYxs+IjP3qKFguk9lA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7192.namprd04.prod.outlook.com (2603:10b6:510:1d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Sat, 17 Apr
 2021 10:39:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4042.021; Sat, 17 Apr 2021
 10:39:38 +0000
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
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2 2/3] dm crypt: Fix zoned block device support
Thread-Topic: [PATCH v2 2/3] dm crypt: Fix zoned block device support
Thread-Index: AQHXMzIRa8gn9aDid0SQEsDAmMromA==
Date:   Sat, 17 Apr 2021 10:39:37 +0000
Message-ID: <PH0PR04MB7416A8D3A8A8BC87EF790B579B4B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
 <20210417023323.852530-3-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15ab:1:4419:a77b:dc28:73ac]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31aad4e9-b7ab-4ec6-480a-08d9018d1989
x-ms-traffictypediagnostic: PH0PR04MB7192:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7192B82EC4E8F818607E0E069B4B9@PH0PR04MB7192.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kS+RuRx4BjooxoHQSS+CLjWpUsv87N72gRBWeaC1M8ORapu8isHOFY9tGuRLz/LO9K7InojTlO920l6VL1SLlxJMd63Rqh5C3dwL4m3mqIXFJD94UurS/PJyzlszof7gOqrITWUHiKZ9cTzSe79YeR3cvar4nefyhb8augySbl2uqW3XqU3Yhd3Y6b5ZiQF7zCp9juUG81Q15P9TLssitlxww0quhAfRWIef08MmL7m4uj4694RrEno0rHfQF1ba6SuohAN86wUE11zfcswTvy9teuXA3rmUuHvySkWaC1BEsnEH8WUrtKmKG6JIlfXHkgHrcEFqPcrSFbJomabvEp4zwwUmmCHb/uHeo4B36yMPCU09IxNjVuyQiagG49MEEorjtpp0zmZ+htL5991hKMXVGmInYARBKA/vn9lqAiZ/e7W/GYepw3MZf3czPlNQQIczIwBDDIMPh2dh8cJU+vM6wC5kE5qsGIkAjN87DNUkHtdHLnGjhxPkli9rg5+TBKFHR0O1Fu2WO6rxNK/0skTqm576LCk2eQHYPyJDyu9MSQtdJ4rznrYkWPbHwR2HQH028BC70H9Wo+45U9B4oUC20w+/qN9cT7y0bCrU+K39E0D2FA2CRcgKbaGftmpiKVn6thqP+zfwXZtHK6CO+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(71200400001)(186003)(2906002)(122000001)(316002)(55016002)(86362001)(478600001)(4270600006)(110136005)(19618925003)(5660300002)(33656002)(52536014)(38100700002)(8676002)(66946007)(66556008)(558084003)(66476007)(66446008)(7696005)(76116006)(4326008)(921005)(91956017)(9686003)(6506007)(64756008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uwFyg0DE7Ef4J5NDnJD0/2tNciDu1zqFowlGRXi/BwC95Vi4wPVCayAUfjDA?=
 =?us-ascii?Q?jH4+pFXoQ45ar6Lp4265ermEgX52fZ/qEadcf+RqncAA6sUEceQ/MITFAkqv?=
 =?us-ascii?Q?8Jfo034yRgY2Y02Q7yl38qvO85vPMfmn23PFHwyejOGcCS6Y6TX+qwY10bhF?=
 =?us-ascii?Q?FCtyrgS09RIhenQ5b15IuvjvwM7gOHtp8SBFTzFIByfS87mgcoY6o1v3gmri?=
 =?us-ascii?Q?u3Tjvv7wAfPa6t43vUIAZrfRpTiMv7o/urLKb9+/+lpXToyF5EyR3cukKhVa?=
 =?us-ascii?Q?GWuE7ADF/QiAdM4+X6fzHHQsgm/mbEhXKJ22R9V0axWpYI+NrCRHvaFSQgsX?=
 =?us-ascii?Q?/0x5WpJmmFA0+XKK7ThKiV+ZhZj0bkPtFjuBldD8plThSMroGoZ+WgmgnIfJ?=
 =?us-ascii?Q?9j8Phdo9PrP2nt/8arhDQkEybyNeuPdNAwGRQ/pyrLos2sqwnJ2zFRgXxYrI?=
 =?us-ascii?Q?CNwDOjLgVg5gt+u/0UCWFB56aWoCCFTfoAjk/hu0MlodjH/H91VuVF4fE+n6?=
 =?us-ascii?Q?+PtXsC5I4s7IEd7TUhKTzJhmeEmwBhyo9Zdj8tWvoBfSM1lNs5v1RD5EH/xH?=
 =?us-ascii?Q?ZOWD6bpk8TNvpskVM41yZluba+dqLZGXvDU+es8rhf6NS7wl2++6LP1DfBLR?=
 =?us-ascii?Q?TolgtBX1r8qEDIPan7ARv1lp6Gdln4uQVvTTvRBYp1pknwzneYF+zarC3oU4?=
 =?us-ascii?Q?79Un0zGKCojwXycLK7JV0RkR03KM2IRHLsklqudiHDqP2qi6KTFDlEK3yhi9?=
 =?us-ascii?Q?h0m4uLZoI933acXFMOLqUZie3le2USVfmTI5RLqqVpM8MGSCdidSFOAfImsM?=
 =?us-ascii?Q?zCT4CcVsw9lshgWsrB+D3LBhdflZJfCjoz+WyCe7rlKpo3YBjPF8jTJn4g1I?=
 =?us-ascii?Q?XJKoNsi+hVGIj9tWrB66t/9NbagLYlaUsMNUffraSmUMojeGzZTb9VaTuqV9?=
 =?us-ascii?Q?lvTdIXhQLYQ4qeckueR4gGZC3ThhWmY3g7N8kRrotByxowzhJzxySyk1FJAo?=
 =?us-ascii?Q?vDKXv3CPGPeGQCkmr4Gn4anQQZRghhCdn4AOZsDFPE1cRCu3Xjxt9CwSgaNR?=
 =?us-ascii?Q?fcqBfWIIzV/U6Jv3ZBkL93mQHzzV+dlEYI/eNL7+m3tCtVr3dW6Rrq2+xeSp?=
 =?us-ascii?Q?iTaX7OTFZKYWr5aH7dRdpnAc+ZI7q9Q04JkGEA+mdBA0OjR0p/1v/h0kiIE/?=
 =?us-ascii?Q?faPpYCMxaY+dhfAKdB25p1mWLnTqP8H8bWjRZUMW/Z/S3GyXARvVb7QWhx/v?=
 =?us-ascii?Q?iAbLQix5MkkR8Qs+UncXQk9O0FYys5aVw8z1WhAt9Wiv9eDay1K4BFOSkO9T?=
 =?us-ascii?Q?aygbCOmlkcsRWx48YJLMNu56janYFlFbGYmxtvLqqHtjlboW82h7aAkWCBuw?=
 =?us-ascii?Q?ybjBxazxXlUZXPvfAltkN4z00DOs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31aad4e9-b7ab-4ec6-480a-08d9018d1989
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2021 10:39:37.9123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wZHY+K+S4DC9jLzj42Phy6ZWBExplPEzV74U/nwBgeSybmWC1Dl7HSE6cjiC+NTjXhR5Egv9hR9JbRpfxHffo1zePabfBzk2WqWyjwpTUeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7192
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
