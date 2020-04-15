Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FCE1A9841
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 11:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895231AbgDOJRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 05:17:32 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:14465 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895194AbgDOJR2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586942249; x=1618478249;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=cdAsaftnyhTiBItQs6rYvoe8Z8scnTuxygryOE92oxtg1mniXlfUzzBi
   h7ClG34icIvAIazaynIVbOXEjXZppNJTJHhZs89k503zQIF+5JtbhLRSa
   1jExZEWkLzWrBDaxDr6J+wGo8+yhyBYRoWvHEaIDvFOTO3uVSt1p60NQ6
   rm5hW/h1iAofyM7oHFUWF7mt1bbpYJib7GNdVZns0mKzP9gNuYFSD9b4r
   S5Ce6hIvp+4a907J0EC/N9+AWIjMQpWoLY4MygJABn3NnxRLYDFK/Ls0y
   PmJrn10k3PS4pK3P33i1+F6UWY2V2MVzIaZAuUWEOCP+wtVixm02xx7ux
   g==;
IronPort-SDR: hk35kDGYzOWp4zYAC8ocqSZCraUa9gZssprA23p0z/WxuWkdckszKuWSUEpaPVSUQMuGXK9gF7
 ZFxhNY3Pp5d9KqaGdtDBBWj+Juyljsm4eMPXSNTB+/0ZXuR7LY6MghRyIhJEYabHwiRfXkqieC
 bKmGMh9byE8VM8rNvHtMYxIh3ohFnI+/AWxvWy/cN+Wzg5/ly165PpTnUDkvmMefgJcEgcuIfz
 i+8KTGE/0ZPH2Mh89BwQFgHPhrdu1a9uytjmys3dHaxit045sIdFsYQN6WBs765WKORYT5raDa
 Ff0=
X-IronPort-AV: E=Sophos;i="5.72,386,1580745600"; 
   d="scan'208";a="135686820"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2020 17:17:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i18V7HagmHncPNZgPP1rUJfWz4EAcU7GvVEhsQkZqEn5CQze5TIbsR2ClnjzeqKLkZT/5jMachZgnXD4olDdFaBKusK1DIKJJbK7xENNcGwdIbs/UE7GI33223/HVWIyAqm1rsX7iMl7uj9wbbEupuN77tkIQ0d+gPOHMKVqkMTURUDamfySwPEsKvMOktIylKwjDot/xe98AJdNJEHGYKka3+TnxJnP58/Fm7wa7KjBujCK4p2+kkC2LL3U6wda4banau4v3s2n+6zWXDE66AzWW74A5dWiXOrrsadAyxcB7Pf9kzT5doAldoB3ziKBS5oBYWsE87q7RNdIvp8rzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=RzU0qxW7TQhlkYyt9W3uNwxt36OSycOWiSHTMU1mdfJ/EW4KPcPM9MeK7Aa6BR5WlI1E0jbOvrwy07XDu6EUDJfguAWC0w1b11JlouVgC+/KbAdDBWXDQWE0EnMrqjW+//ex7Q6zqgFoIx25IYYITNe+nZxnoAi0IqWdXyyfDbgpnFP80ZzyQHDGARO8sQbx/uS6NZQetz647+fF/HwucqnXqaefh4nogGJZOMNvIoKItxWQizxh4deGqVY1oZMVT+Vro6nSTthGhXbXl6HguxUQhFwH2L8TgSrYvWZZJBhsN21+IanO2aqbpRElLW82ddxLjV7dzEArS+ap77oN7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=AzsgPysGBJGfUr7kCZAivkF5ybe3cjCnW9dNe8Zhx3dXKdL0OvyaC8EqX8sUV9feXf/07OkQnmJufKVCYBSYs6so8ES3PETiC4Id6b8C3Uljyvz/3WHG8tS90QzmKHuZOrJzsE3k6QpkjNukNWQNv4L3Nhq+ry5U61u87z/QP9o=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3648.namprd04.prod.outlook.com
 (2603:10b6:803:46::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Wed, 15 Apr
 2020 09:17:24 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 09:17:24 +0000
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
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v11 03/25] mm: Ignore return value of ->readpages
Thread-Topic: [PATCH v11 03/25] mm: Ignore return value of ->readpages
Thread-Index: AQHWEm3kXqLq3+slIU2TSjQVADTM/A==
Date:   Wed, 15 Apr 2020 09:17:24 +0000
Message-ID: <SN4PR0401MB35985342EC4B346DCF6E47129BDB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-4-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 57014d5b-8a85-4fd5-a7b7-08d7e11dcf55
x-ms-traffictypediagnostic: SN4PR0401MB3648:
x-microsoft-antispam-prvs: <SN4PR0401MB3648DF0AB80BA63113E1CF329BDB0@SN4PR0401MB3648.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(316002)(8936002)(7696005)(66556008)(71200400001)(66946007)(64756008)(91956017)(86362001)(4326008)(9686003)(66446008)(26005)(66476007)(76116006)(7416002)(186003)(54906003)(558084003)(19618925003)(5660300002)(55016002)(81156014)(52536014)(110136005)(2906002)(6506007)(478600001)(33656002)(8676002)(4270600006);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rniTLGXvJXgW6JK2sUR1/XLSThA6ieNtsfxl1n+cQBGxvE9ZOoqbBiwJzQMD9oGqNhjeqprWqaONYGHjYO4Q9nl+eIAU/lRG7fcAfpxdSAKAuzZUOJlyc2C3r7xIhq0+pLTdLTSHOTMzGJAaPBl9daL5Xjy8Hv0GrTqiESJpgPUUFgPOCjcW6ZbZLItjGEbmn7o9H61Og+KCuv7TMP1CU6d0Wb3LwMkR76f+fKF49BFL9M7N5XwGGt+uTm6N+iWXgqekAt1ENLeGu1NvIr++Y6uVmLkF4priioh5sEnxIK7KiobEw6c+63Gv+qiqIRNADbPQ8RHSyGLSOEtwS4sfwEan4MZs5p5n5OFBd5fMMcV1Q1oe5yf1mpRoOSpBETK7bGg9WygsdbMjdxGtXNcxGTxDvmEwcMRGur+7bEg8/RpmSH50wiD+LE4ugMJXc+3M
x-ms-exchange-antispam-messagedata: s7qYqR9eN7xrN7e9T2xU72Dtqk6WG15tS2l27vqGalrqnDj2UkfCc4ahqFKj4ArRlz3PjS82n70lx3qyoN06RmDO/7+gwNCgH8MJ7ASnohHsUjswIUgiDuYBzSAyYhqbVzHMDh+9PbX0HuWtT6BOdA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57014d5b-8a85-4fd5-a7b7-08d7e11dcf55
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 09:17:24.4123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5uQ67XI+LDSXRymC8i8GEceBFw3RinJNUQWorx1KZ1DYCRvfbMIZcAmJvKKEjrTNzp5CVjzSeaGPC9s3njliFb1E8oDftqzqC/YpNU8Jzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3648
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
