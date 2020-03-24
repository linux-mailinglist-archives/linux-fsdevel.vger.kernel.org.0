Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44B4C1915AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 17:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgCXQHt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 12:07:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25304 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgCXQHt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585066068; x=1616602068;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8j2s1hS95cG896w5f0u7W5I+ZoamYL5qtuFf/743Ll4=;
  b=M+70BLsoJc0YxRctqgUvAUF57gskR9D8ricJO6100l2fHGRC0ttuj082
   aU3pNScQErdwkjfug3vAN4Og++KRaudLrIkACmij9YKcFW/wLTRfUygey
   53qcL364r6cFYU0jRbEwmHpXg5NnVVrW7+XsenJPeVkTY6+QzmBYDSlx3
   WPStzkvZoCp1FhEo29XIoivwPTV32w1u/yqgSyx3usJMXcuc4Pklebq7g
   Xygn4h/zRBIkC2cZkvHDQuxFonhFWwFtpqWevxEEfjut2Y7AuHKnFjjxv
   72ZQ+a1BeYpoQxYelSoFz/Rv+0fWvKQ/GxA4j2tcE7wGFHjQHBwLNL5US
   w==;
IronPort-SDR: f8SRLFkS+qvxuLhZWhSp8jJRSOmzcIfh5B7TqRIpzv18bz6Oep2szxVpPZtcRqV9yvcYE7IKCn
 WuQ4LkQgj9WBykdck5y9mTsjnChlJohaK7nhJsvRgMENqFT9rK+7nzh3/PSPc6Tfj6Gkeeoav1
 T6gvnKhp6r452OBO62lYhjwSl47ixtUyuAY+LCwruVEfXx4ymPCa54FbiiM422os/ss/NSumhu
 BQmFlSlG6wfbLi8s9G6QcyMSG4+gsXDxKKZgv5GpSFeDnSmq77ecG7VlqLpB6IHAKEvApn3ysA
 Oss=
X-IronPort-AV: E=Sophos;i="5.72,301,1580745600"; 
   d="scan'208";a="133811562"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2020 00:07:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOue4SLQ/mMnBxsVmizecoqoukfclEz4LrhiO52q0kJpqdxe0BnOu35gQqqwuB5H3VDxbezoUwO7SBVokRiYwPQCcQ16r7IQYxBRPFmTStiKa5xItMVPOjW+0J3mJS1RNjGliihQQmYn50LYvPiwPLxtEcsXrXrZHj73zm3+az1deQUCgkCxw0cYjZq1Vv+zbjF7XOO0vB+msFWC+DyrlzKJM3imVSwcSod7sOnuCNkgoeIRLEviGMO5Ty8YvIDrCAUFLnXM/cYGk1xBklzOgv01N/uN8e75+Fr+5O3wTswECkKOrn3mnWoWnkli8uq5F7wcz4NZMgGlcIqNkOZLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8j2s1hS95cG896w5f0u7W5I+ZoamYL5qtuFf/743Ll4=;
 b=N0D62lFoKhYNtwfiJqtUmzThhMtcSHN0/bUJRlVJ8o5ptiLVrItmuuWiW8qudFmj8C0mRI7rf9hph2/xE1Rqtbq+O3FKz76Fcwf7IbEhOJ7NItyKeEP9JGxSR5BPVPJOflFw3XKmp3R6ONFD5diFVrPdSBHWf8DZoFIqkcdXwMd4MKc5T+CIVYxK6YAYCHX6JC1CJB3JRXFYPNLrTDGJUeXwA/j58UiOYX/Vp+ApAFnlXHuZcHM3ITjCAbaji+Nv/1VgJbFBVERDi90hhs1rUHuKfmNmN1Y7x+UH96jtYf8PF+W3cY03mb0yTCcVHocT0K2VixnhUNbJdaefhaONlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8j2s1hS95cG896w5f0u7W5I+ZoamYL5qtuFf/743Ll4=;
 b=Ss3NtDWXMgke03g90RVqwco0ZgyDdOtGS0/jWzRKJq3WUuA4A7JHxQXFMo7POdpHxuEWBHME9iYMBmx9w35rykaNyCknGfN4w8a+K6E7y0gUFNOM7ZfrJ1niiQgSmm4gqVE3sYkqmCEMdFrQDW3HRxThoM4e79LAFSg8sqCjysE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3549.namprd04.prod.outlook.com
 (2603:10b6:803:4e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Tue, 24 Mar
 2020 16:07:46 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2835.017; Tue, 24 Mar 2020
 16:07:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2 03/11] block: Introduce REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v2 03/11] block: Introduce REQ_OP_ZONE_APPEND
Thread-Index: AQHWAfBskP1byqASXU26hlsR5DkSLQ==
Date:   Tue, 24 Mar 2020 16:07:45 +0000
Message-ID: <SN4PR0401MB3598BA5AA8B90140B483B4829BF10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
 <20200324152454.4954-4-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 34c4bf89-cfa4-4c97-26f3-08d7d00d7dd7
x-ms-traffictypediagnostic: SN4PR0401MB3549:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3549D21E90BC353FE4B7E0169BF10@SN4PR0401MB3549.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(81156014)(8676002)(5660300002)(66946007)(81166006)(52536014)(76116006)(91956017)(8936002)(66446008)(66556008)(64756008)(66476007)(4326008)(54906003)(316002)(26005)(186003)(6916009)(86362001)(7696005)(71200400001)(6506007)(53546011)(55016002)(9686003)(558084003)(33656002)(2906002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3549;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HLHMBdCmH1V4szHPzoeKIa2M+Njb7du1X1UDC2E/RggCR0g/1/LkAGerRcbdFSKZn3gW9Yn9z0yNQW8pHhhmlqsa8l0hafpfB2D1XP4a1VeE7MEt2pZwyrIeepJTLLfoKNZu558WYnGAl3BJCVKVXCDXKduf4X5cEy7ZZmWnbeuITOSLNcFG6+IyI83VVl/6pCPrp1wEOMZ93A8HyIdmlJ2lxHECO2eqzA0VTrVI9N9IvqmL1Fe0krvNPtO6Fva/9dNIWpfqQrY1sd8QtMa9TfswQYOw36KLnXJF4tO44K5MA1eohCpS066Q5aZZkzPdZKmAz2YwGUvp6maDckeaszuCZIAs6m5foI/Oq2egF7nDvPj/WDOqz3wokRN2bdphJE37XMSVwGpdJkkI3F4reaneoPLGavTbYtDXxHtGJNx4hPNeiF0qG25zXUjDEdVy
x-ms-exchange-antispam-messagedata: MjRiESTnZYZywDyzURat0p3cCcRXssPUH8ZUIJSR1wVCcOvPu+gUYlfdAXSgYwvLNvSUWwwM4pLBzYhd3jsQt8rlIYT5n01/OMHSVK6t1UkBISH6xWTX+sIgL3Nqa9UHsMv1keSFafyBnKNXNUW/2A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c4bf89-cfa4-4c97-26f3-08d7d00d7dd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 16:07:45.9629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdWoha6dem5hOgxlkSUygjFCcFLyf+wCeDY+ljcjT2KePdW9CO0XMcgYeLNwVh5FElEM2H3UmG0hgVHdYxFYiKG5tVPnZIM+Yxnhmp1mo3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3549
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 24/03/2020 16:25, Johannes Thumshirn wrote:=0A=
> Also add bio_add_zone_append_page()=0A=
> similar to bio_add_pc_page() so producers can build BIOs respecting the=
=0A=
> new limit.=0A=
=0A=
Bah, this statement is not true anymore, bio_full() does the necessary =0A=
checks now.=0A=
