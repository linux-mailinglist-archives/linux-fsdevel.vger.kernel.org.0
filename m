Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F4A230A34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 14:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbgG1Mca (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 08:32:30 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:38452 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729456AbgG1Mc3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595939549; x=1627475549;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=coMmgj3cOhqVq3/jSTGLy3c7QIqos+/uC8GMnzmP+3ARXZV79A/tIbU9
   hWIwMgdRDy5+i74fP+ttyC5OflW9vCwpgx6tUXPQ8jKIGl0Ivcj7xTTmA
   1sUKfSw8luXOI40UPI24Q5Bi/0+HiM7HrhBYa4Ut9HPDbI5Gq/GJJIhMc
   AfFrG45Tkq7CBknSOSrWtBXGrTC6U7plGopEnXTVz3gOI4/R9SHpZNRpI
   EOVTVPBj8bQWqlMJEsyY8chOtpaQtSMrsBYZpYvq18Kn3NdQuY5ddOuqB
   NhzagCidDaQ7rOw9dCyPsyr5A6U28if25NTD0+V6RnoFA0l5r1U74v3md
   Q==;
IronPort-SDR: JE13P1BMHLoj89jVU4/EmhOTBuTlfSgneD0QCPaQ/vse4GE4e049GBUZgE2kW61BuxyeP5k0I3
 6MuYVpq3QtA5tzmKL1sicegGsRYVLIJtvcCCwVoRj+9rytNVIFGiMBfLizxfBAHkkFXhBnNMKl
 LKSEu3i+bhUIGZ4IA/pU7hxAjxQLV1FV7uap5IsFazd1KpMhFZeFfWWpFpsdXD6uvgjeqF6bNr
 AgsahQGU4ejIxmiLYtySas3vRUAwUWB5vvX8QChYDVCM32FAfTbbtKbThlK3TFTHomeNSEKtE5
 90Y=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="143551334"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 20:32:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJLLRgf7UoqnIcEt59GKCXoJxcvcQMHG4G5XyZf8jKnSyqpTOmLdq0IXnQTfkybNIYXTgIlgc4Xi0KMFmabl+hHzPF6p9q6Efo259GQxVc0Y/3JiXf5q4z0+QwQlQvBY/9EgaojP8wQPXOcbQ9dIMbNAOhs6DvDULkyjCjxAVZtL4PipNBkAcLQW4TY30OgmRiwZLL04P+e+NSSUTs0LZyxpkQqt7BbrD0971PPirCb8nFwk0lumYwIumsTO1rssBKzOBqsdf4HFDP+yoxNu0jDqo/m5S4Vw8qobp5JUBSk4RZnEmkbBsoo4H2v66WJ+8oZxk+Z4J9EG52ScyC6I7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=TFesnzgH5vMmVF2OITu+bjPqR016RaLNRvOtmpIhfuJif3PjqzV5UvJX+mR9PmLs4HOj49FaZG1J7PWpetZMM/K3le0vj2Yu035UbppiALMkpdaneK5j5uCOsxKa8buiQmfC35KhBhdsM/2ux8LugjocrGRktOHeRNpCJOMyWy23A1Cr0hj4+AS646FSmF2kUn68TYbNJdHejDTO799grzE9T7XSDB9t9oQf4/FGy+swo7HLblqSyUVuJgY2DuKHLkaoaUBq4WDuN2PvZ+5UCRCWM4UEoR9CgVrdEw5GyfAPWxMZhzbKccggNoLpSkkvyVh5N8l1TBL3w+7H0JmtAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=lBW2YXfUP9SStzN/93CIhiPOL35rp/NXiEh1x0WsfKlP1UTmpOxZBe0+TXo4uhNPXypBxV+f90Caz7XUZ6wnzywMnseJHwkpJRVn5nZ8XZVpXbQu7G5Q4HJP7fNI8NsXCKHBzpbDI2MGt9LLa+rdvswWj0ACvkqjI0QDcacWGZo=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM5PR0401MB3590.namprd04.prod.outlook.com (2603:10b6:4:78::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 12:32:26 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573%5]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 12:32:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH 13/14] bdi: invert BDI_CAP_NO_ACCT_WB
Thread-Topic: [PATCH 13/14] bdi: invert BDI_CAP_NO_ACCT_WB
Thread-Index: AQHWYYzZAPYqjABppU2mZeEMm4kZyA==
Date:   Tue, 28 Jul 2020 12:32:26 +0000
Message-ID: <DM5PR0401MB3591D067A9C4146859BE83BC9B730@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200724073313.138789-1-hch@lst.de>
 <20200724073313.138789-14-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f57ee145-7191-498b-ec75-08d832f2497f
x-ms-traffictypediagnostic: DM5PR0401MB3590:
x-microsoft-antispam-prvs: <DM5PR0401MB3590FB1F17B89990D2FF002A9B730@DM5PR0401MB3590.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ylVA0yChln8JJ8IChNgbfAB1et2p0Gw82Iti4THRh8KF0/lGbDXVX2wD7V0pDGEv2TPs9zhUBUrs1r2Frf68OKmke5X1h7WJbCXipLfsKwNK74S5uh2/1VI95gcbcqJL6wUQQdP8NyRkKBIJcf8qXT1bDn67S81i6RZkeQl0OVDQPnJY9p0MOyImfDxzJXpmMtDP9TttrCBhJngqkW3rFxA67kJeWJaRfEPDT58jc+dxSzwrGuwRcKHyUxomPtEUMV08S+Ib5O5BY/j3A7gRvuMvZBNenydhtN91uneidlGsyLTqcX7q85yGxbCcKN6ztWJrjLAlNJo6CZ21wctKqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(33656002)(558084003)(52536014)(4326008)(66946007)(5660300002)(66476007)(66556008)(7696005)(55016002)(64756008)(91956017)(19618925003)(316002)(76116006)(66446008)(6506007)(4270600006)(9686003)(110136005)(54906003)(186003)(26005)(7416002)(2906002)(478600001)(86362001)(8676002)(8936002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mr/TPk+gsvwHIxGjSB8h7hiRrLCh3oUV5CQz1ShZ32dXuqQoorJ+jpHfZOeTyQaXH7XSAwrztG81YFtXxt927I2uHO9HcFVwwMtYGRhZSIUL9otxKk3Ek2mfTew6gl1n2LJnRwtlrm8WQWlZAZX5Aig7QtI1bmYOc+GJKNGkShMwhFosGMeZ9jJRVgsEVsvOYmoe6W1bV4FN9pVjcySAoHT4uaYm2HDCMVWLz+LSqbDg5ktmmTCCby3bLmCz8I9PwAHQJhtP4mtN0fhv4Ds8DbczXilGI7y0P07SPWuSQsBlmUmRh6LoIg5ExwDm/PX5s6lpKE8Kfgzzsykad/AFZrdNZYmwwLflgPIoBaogrKA36Ws5/OFRC6fZoA7oLo1ndvVpn1mWJtNzZ0QtRZjRmDmqxQ9eglqZs1KHYhAjGjUBGL/XpUaoPRCBi+I6JWf/XEkUMLIpjdWEQfSlP5uhuyIxojZqOQsUbEozWKhx8CHqWVDdEIongGUbnsrujfTN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f57ee145-7191-498b-ec75-08d832f2497f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 12:32:26.8290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJoQSZGlhKznEX5oWkgVl+HFz8leXCCRuWjDL8DzebwUqtGZ92d3aJwK3opzUNE5USNAmFEOJl1GmZZeTx+fcKRh0yq5ov1uk/5Kp4P+js4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3590
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
