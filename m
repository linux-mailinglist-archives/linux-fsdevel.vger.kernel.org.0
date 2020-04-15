Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB581A9852
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 11:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408400AbgDOJTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 05:19:12 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:14587 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408389AbgDOJTF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586942346; x=1618478346;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=BMUeQ4jbmPmOfbeeOoPdA8AqHu++UPBLtkncUj4UnsQOqC7iybMOcqse
   WNeKEo5ksReQFA6j1irdn57hmFucPbTCjxolqpYgHo8itpHHw7yn7tREe
   X8yP4oOLpv/pJ2I3rceqyJFc36wWsN+5+dRQxqhBOc6eSjPL8Yhc9OB6f
   hLV1tFJDJoEWr5VS6RegT6gtnRs/OTK7m/9rqXESf8Omc6hcnY2PaxNt6
   SpP4+hhym+EIA4LhaCDKduKH5jrrfNR8gAEjtRTvcH1sG9XPl1UmVbrar
   Hwwy+in2lx5ARWUWyvkEPq9oKSp9uf+nXZfqPUjEwHF91sGBpuhOW//30
   w==;
IronPort-SDR: 7kjzK1Ad2wI5b4+VcSOfMv6/ppyrbsci/xuhvxCYoArjjognUejG8HHW6YMl9AM5WbSDToOdLP
 X8dYv47DtU4cxM0zSGBTTCmlK8wP7DfCa/ONMGdAtkVZHrIAUlag/V94tDHZx5Uqw5rEVLtGTV
 YdIi0d+qBDUxVDxPM3/vVeBoffG4x+z2tpO+sACAhLugH1NqtrgauHv3RN5nxrFamA+IwR3B5P
 YE+2CSRf8cu8pNZHTR4rO7658OLaGp63lrzvi2P1PE8rrc2pCOuSOMxkZQ6mYnVUJEk/ZuzROQ
 VcE=
X-IronPort-AV: E=Sophos;i="5.72,386,1580745600"; 
   d="scan'208";a="135686908"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2020 17:19:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEIej4lv6sJdhnVg1ul+ORze3ERisffSO3OanZb0O1wI3AORSBjTn78SWW92xu0021vwnrNqO4ShrmSBBwQzZqmzxd9w6KUxXwWSbnKlNQuIdwc9rfKugA4rtoYJbON/HED1PI+xjnyJEdH3sW/EU/Rjdpf9xBikf3MMtZQFF9qWkERdvH+itN3y1yTZ8IoIcSviTChJmb22CO55516EkQG/FP+2YAcwjKxcwD8hoaAQDCkwtUOnFWQVe/xjm52A3M7W2pmGZ960FM0diL0RyF7ZVqjDCPDzObjmsNP038wr5YcACGr87Qb/Nrua5Ls4QrAtzMrG+kvbqI9JRC+Mew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=L3QuweCo3yGAnIdr1zoMtxP65BooYVXgXMp+3RpIfpoTlOaafpdoyDDn1PLoMlD81Hm9STsQ3rh+sRzVT8Qvi0visziJ3jT5Hb3ExqSSQuO1OOJj89CPeNYJFlCa8l6YcRUp86dH556nwW1L2Xt/S+Q1/kWsew8G/HUDiBiWKb5xK5hvL0flaTkihiNvBiofS+OmYwFQfe5UMEICCYFdbubpInbNuLsyrSB83acjP7o32+DeK4shMcAlf1oikvJt8h+xW7FMxFfXJLpKLDLTHvNqLfqbhS+NIr+XJ4v0vO4toqRKSKT/5vSe0wqzjgWgbZU5P+2Iu/fQWsc7p2qi7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=cediymMqXsejz8XaN4L77SrepB3oVklmN6NKWIr1QSKzdeH9pOzsLO9HNKz1QTXeYWJ5XjYSfC2k3/2hqoSxmUIxawuSk2zcBOVeUbDxM9JAV49zV7slMNGV5PNCPPC3PypoYaJo30oCC5UrP9hfwVHZdeSH6eLrb3XOK7Enhl0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3648.namprd04.prod.outlook.com
 (2603:10b6:803:46::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Wed, 15 Apr
 2020 09:19:01 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 09:19:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 04/25] mm: Move readahead nr_pages check into
 read_pages
Thread-Topic: [PATCH v11 04/25] mm: Move readahead nr_pages check into
 read_pages
Thread-Index: AQHWEm4IkvFnOm+tn0ujKbHOMv4ngA==
Date:   Wed, 15 Apr 2020 09:19:01 +0000
Message-ID: <SN4PR0401MB359877A9FA5F54D9B9478A409BDB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-5-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 34e1ef26-dcd0-432d-5d98-08d7e11e0926
x-ms-traffictypediagnostic: SN4PR0401MB3648:
x-microsoft-antispam-prvs: <SN4PR0401MB3648BFA0531D55F928A734619BDB0@SN4PR0401MB3648.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(110136005)(2906002)(6506007)(19618925003)(5660300002)(54906003)(558084003)(52536014)(81156014)(55016002)(8676002)(4270600006)(478600001)(33656002)(71200400001)(66946007)(8936002)(7696005)(186003)(316002)(66556008)(7416002)(76116006)(26005)(66476007)(91956017)(64756008)(66446008)(9686003)(4326008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ts4kbZfVIx3jY3ipP2XDo22PJ/uDpAUEebR5XqTR/mqTdQxW52hs+0U7TYZvRVbRm8ZHawitYkINlnyCicp/zaMoChF35gNTbuhUiNocBU1MrXuf+a4EuKOhrzn3WhczzDeOj0Acl+U++zZr5qa2Yn1SETaUqhqrQOPNDTChvu6C9bxswB787iloZ3k48x4rjZkOI25b8vl6jrAuA7VG2nARo2dQhPCadhpHzDJaglBmGHT3TBhvqWe47qXvsvQBei6VtNzbPXIoD9t7CEjgLGshUTx7oLGsxK67gsAKdpxD2PqzK7L2bvfUJG04JXMUQu7Ht06ocRyFS2WXEJRZwepDKFRy4zVwYxUppYPLEFcGmYXk56xr9oAxKyr9iMaHKripTCrf55JgxIiEs1M8z4OGHnyZfb4C6NlERG1jlclZMfgY1lUPkqLTiuyiDRe5
x-ms-exchange-antispam-messagedata: G5b00ZkXeotDfHr5faVQP7pQ8wJ3BUN2v83+0ZSaeaqLYTG62rwp0tpukyet2r/12j/07OjwMd35u20OT33lASk1RWliQXm3Y5wCN2+4chVeVuKQjJoMrbfgUiVbiMwJGAN4lrZmXEfLSfXxRIdFAg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e1ef26-dcd0-432d-5d98-08d7e11e0926
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 09:19:01.3852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7awMuL++xctXgRnNnTlkMtxoRGQgn6ttJ1Pw3s7lCSFjbymJ67INYV6uYM9IJ/lwJ2++fSVytVZUtgBEza8yH7+QrjyHiKW1mXwoRzbBDfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3648
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
